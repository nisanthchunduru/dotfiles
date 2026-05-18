# alias dark-mode='defaults write -g AppleInterfaceStyle -string "Dark"'
# alias light-mode='defaults write -g AppleInterfaceStyle -string "Light"'
alias dark-mode='osascript -e '\''tell app "System Events" to tell appearance preferences to set dark mode to true'\'' && sed -i "" "s/\"workbench.colorTheme\": \".*\"/\"workbench.colorTheme\": \"GitHub Dark\"/" ~/Library/Application\ Support/Kiro/User/settings.json'
alias light-mode='osascript -e '\''tell app "System Events" to tell appearance preferences to set dark mode to false'\'' && sed -i "" "s/\"workbench.colorTheme\": \".*\"/\"workbench.colorTheme\": \"GitHub Light\"/" ~/Library/Application\ Support/Kiro/User/settings.json'

alias intel='arch -x86_64'

dock-icon-size() {
  if [ -z "$1" ]; then
    echo "Current Dock icon size: $(defaults read com.apple.dock tilesize)"
  else
    defaults write com.apple.dock tilesize -int "$1" && killall Dock
  fi
}
