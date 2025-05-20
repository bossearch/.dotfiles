{...}: {
  home.file.".zshenv" = {
    text = ''
      ZDOTDIR="$HOME/.config/zsh"

      export EDITOR="nvim"
      export BAT_THEME="tokyonight_night"
      export FZF_DEFAULT_OPTS="$(< ~/.config/fzf/.fzfrc)"
      export FZF_{CTRL_T,ALT_C}_OPTS="--preview='~/.config/fzf/extra/fzf-preview.sh {}'"
      export KEYTIMEOUT=1
      export AUTO_NOTIFY_THRESHOLD=30 # Set threshold to 30 seconds
      export AUTO_NOTIFY_IGNORE=(
        "nyaa"
        "rb" "hm" "nix-shell"
        "fh" "fkill" "fif" "fzf" "fsys" "fgrep"
        "yy" "sy" "yazi"
        "man" "nvim" "tmux" "tm" "fg"
        "lazygit" "newsboat" "toipe" "neomutt"
      )
    '';
  };
}
