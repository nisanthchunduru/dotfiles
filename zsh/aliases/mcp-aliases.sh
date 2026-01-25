mcp-inspector() {
  local client_port=6274
  local server_port=6277
  
  while lsof -i :$client_port &>/dev/null; do
    ((client_port+=10))
  done
  
  while lsof -i :$server_port &>/dev/null; do
    ((server_port+=10))
  done
  
  CLIENT_PORT=$client_port SERVER_PORT=$server_port npx @modelcontextprotocol/inspector "$@"
  # disown
}
