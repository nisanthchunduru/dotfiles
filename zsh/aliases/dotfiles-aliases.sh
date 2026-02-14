alias symlink-dotfiles='rcup -d ~/.dotfiles/ -K'

resymlink-dotfiles() {
  rcdn -d ~/.dotfiles/
  symlink-dotfiles
}
