import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import unittest
import uuid


ROOT = Path(__file__).resolve().parents[2]
ZSH = shutil.which("zsh")
MOCK_CLI = r'''
import json
import os
from pathlib import Path
import sys

args = sys.argv[1:]
with open(os.environ["MOCK_LOG"], "a") as log:
    log.write(json.dumps([sys.argv[0], *args]) + "\n")
if os.environ.get("FAIL_ARGUMENT") in args:
    sys.exit(7)
installed = Path(os.environ["MOCK_INSTALLED"])
if "--list-extensions" in args and installed.exists():
    print(installed.read_text())
if "--install-extension" in args:
    installed.write_text("zaaack.markdown-editor\n")
'''


@unittest.skipUnless(ZSH, "Zsh is required")
class CodeWebServerTests(unittest.TestCase):
    def setUp(self):
        self.workspace = Path.home() / "tmp-workspaces" / str(uuid.uuid4())
        self.addCleanup(shutil.rmtree, self.workspace)
        self.tmp = self.workspace / "tmp"
        self.bin = self.tmp / "bin"
        self.bin.mkdir(parents=True)
        self.home = self.tmp / "home with spaces"
        self.home.mkdir()
        self.code = self.bin / "code"
        self.write_mock(self.code)
        self.server = self.home / ".vscode/cli/serve-web/test-commit/bin/code-server"
        self.write_mock(self.server)
        self.installed = self.tmp / "installed-extensions"
        self.log = self.tmp / "calls.jsonl"
        self.function = ROOT / "zsh/functions/code-web-server"
        self.env = {
            "HOME": str(self.home),
            "PATH": f"{self.bin}:/usr/bin:/bin",
            "MOCK_LOG": str(self.log),
            "MOCK_INSTALLED": str(self.installed),
        }

    def write_mock(self, path):
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(f"#!{sys.executable}\n{MOCK_CLI}")
        path.chmod(0o755)

    def run_server(self):
        return subprocess.run(
            [ZSH, "-dfc", 'alias code-web-server=false; source "$1"; source "$1"; code-web-server', "_", str(self.function)],
            env=self.env, cwd=self.tmp, capture_output=True, text=True, timeout=15,
        )

    def calls(self):
        return [json.loads(line) for line in self.log.read_text().splitlines()] if self.log.exists() else []

    def expected_calls(self, install):
        data = self.env.get("VSCODE_AGENT_FOLDER", str(self.home / ".vscode-server"))
        server = [str(self.server), "--server-data-dir", data]
        calls = [[*server, "--list-extensions"]]
        if install:
            calls.append([*server, "--install-extension", "zaaack.markdown-editor"])
        calls.append([str(self.code), "serve-web", "--server-data-dir", data, "--host", "127.0.0.1", "--port", "8000"])
        return calls

    def test_dotfiles_function_loader_makes_code_web_server_available(self):
        zsh_dir = self.tmp / "dotfiles with spaces/zsh"
        functions_dir = zsh_dir / "functions"
        functions_dir.mkdir(parents=True)
        shutil.copyfile(self.function, functions_dir / "code-web-server")
        loader = zsh_dir / "functions.sh"
        shutil.copyfile(ROOT / "zsh/functions.sh", loader)
        result = subprocess.run(
            [ZSH, "-dfc", 'source "$1"; code-web-server', "_", str(loader)],
            env=self.env, cwd=self.tmp, capture_output=True, text=True, timeout=15,
        )
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.calls(), self.expected_calls(install=True))

    def test_missing_extension_is_installed_before_starting_the_server(self):
        result = self.run_server()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.calls(), self.expected_calls(install=True))

    def test_installed_extension_is_not_reinstalled_on_subsequent_launches(self):
        result = self.run_server()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.log.unlink()
        result = self.run_server()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.calls(), self.expected_calls(install=False))

    def test_extension_id_must_match_a_complete_line(self):
        self.installed.write_text("other.extension\nzaaack.markdown-editor-extra\n")
        result = self.run_server()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.calls(), self.expected_calls(install=True))

    def test_installed_extension_is_found_among_other_extensions(self):
        self.installed.write_text("before.extension\nzaaack.markdown-editor\nafter.extension\n")
        result = self.run_server()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.calls(), self.expected_calls(install=False))

    def test_listing_or_installing_failure_prevents_server_startup(self):
        for argument, count in [("--list-extensions", 1), ("--install-extension", 2)]:
            with self.subTest(argument=argument):
                self.log.unlink(missing_ok=True)
                self.env["FAIL_ARGUMENT"] = argument
                result = self.run_server()
                self.assertEqual(result.returncode, 7, result.stderr)
                self.assertEqual(self.calls(), self.expected_calls(install=True)[:count])

    def test_missing_server_reports_how_to_bootstrap_without_starting_anything(self):
        self.server.unlink()
        result = self.run_server()
        self.assertEqual(result.returncode, 1)
        self.assertIn("open its browser URL once", result.stderr)
        self.assertEqual(self.calls(), [])

    def test_custom_cli_and_server_data_directories_are_respected(self):
        self.server.unlink()
        cli_data = self.home / "custom cli"
        self.server = cli_data / "serve-web/test-commit/bin/code-server"
        self.write_mock(self.server)
        self.env["VSCODE_CLI_DATA_DIR"] = str(cli_data)
        self.env["VSCODE_AGENT_FOLDER"] = str(self.home / "custom server data")
        result = self.run_server()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.calls(), self.expected_calls(install=True))

    def test_most_recent_cached_server_is_used_for_extension_management(self):
        old_server = self.server
        os.utime(old_server, (1, 1))
        self.server = old_server.parents[2] / "new-commit/bin/code-server"
        self.write_mock(self.server)
        result = self.run_server()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.calls(), self.expected_calls(install=True))


if __name__ == "__main__":
    unittest.main()
