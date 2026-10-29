# Added by Kiro CLI
case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="${PATH:+$PATH:}$HOME/.local/bin" ;; esac

. "$HOME/.cargo/env"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/chunisan/.cache/lm-studio/bin"

# Add ~/.local/bin to PATH for cursor-agent
export PATH="$HOME/.local/bin:$PATH"

# Added by Antigravity
export PATH="/Users/chunisan/.antigravity/antigravity/bin:$PATH"

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path bash)"

