{...}: {
  home.file.".zshenv" = {
    text = ''
      ZDOTDIR="$HOME/.config/zsh"
    '';
  };
}
