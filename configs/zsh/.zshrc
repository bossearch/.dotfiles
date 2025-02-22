# ----------------------------
# Initialization
# ----------------------------

PROMPT_EOL_MARK=""

# Initialize Oh My Posh
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmypost.toml)"

# Initialize Zoxide
eval "$(zoxide init --cmd cd zsh)"

# Source additional fzf extras
source <(fzf --zsh)
source ~/.config/fzf/extra/other

# Check if tmux is installed and load fzf scripts
if command -v tmux >/dev/null 2>&1; then
  source ~/.config/fzf/extra/tmux
fi

# ----------------------------
# Environment Variables
# ----------------------------

export EDITOR='nvim'
export BAT_THEME="tokyonight_night"

# Load fzf and its related configurations
export FZF_DEFAULT_OPTS_FILE=~/.config/fzf/.fzfrc
export FZF_{CTRL_T,ALT_C}_OPTS="--preview='~/.config/fzf/extra/fzf-preview.sh {}'"

# ----------------------------
# History Configuration
# ----------------------------

HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=1200000
SAVEHIST=1000000
HISTDUP=erase
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS

# Don't save wrong command to history
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

# ----------------------------
# Aliases
# ----------------------------

alias ls="eza --color=always"
alias la="eza -a --color=always"
alias ll="eza -al --color=always --no-user --no-permissions --no-filesize --no-time"
alias lll="eza -aloh --color=always --long"
alias mv="mv -i"
alias rm="rm -i"
alias editzsh="nvim ~/.config/zsh/.zshrc"
alias v="nvim"
alias c="clear"
alias cat=bat
alias cat-og='\cat'
alias ..="cd .."
# alias rb="~/.dotfiles/scripts/rebuild.sh"
rb() {
  ~/.dotfiles/scripts/rebuild.sh "$@"
}
hm() {
  ~/.dotfiles/scripts/homemanager.sh "$@"
}
# ----------------------------
# Keybindings
# ----------------------------

# Keybindings
bindkey -v
bindkey "^?" backward-delete-char
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# Vi mode cursor indicator
export KEYTIMEOUT=1
zle-keymap-select () {
    if [[ $KEYMAP == vicmd ]]; then
        # the command mode for vi
        echo -ne "\e[2 q"
    else
        # the insert mode for vi
        echo -ne "\e[5 q"
    fi
}
precmd_functions+=(zle-keymap-select)
zle -N zle-keymap-select
# Yank on vicmd
function vi-yank-xclip {
    zle vi-yank
   echo "$CUTBUFFER" | wl-copy
}

# Paste on vicmd
zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip
function vi-paste-xclip {
    LBUFFER+=$(wl-paste)
}

zle -N vi-paste-xclip
bindkey -M vicmd 'p' vi-paste-xclip

# ----------------------------
# Custom Functions
# ----------------------------

# yazi function with cwd persistence
function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# yazi with sudo
function sy() {
  cd /
  local tmp="/tmp/yazi-cwd.XXXXXX"
  sudo -E yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      builtin cd -- "$cwd"
  fi
  sudo rm -f -- "$tmp"
}

# ----------------------------
# Plugins and Settings
# ----------------------------

# auto load plugin
function plugin-load {
	local repo plugdir initfile initfiles=()
	: ${ZPLUGINDIR:=${ZDOTDIR:-~/.config/zsh}/plugins}
	for repo in $@; do
		plugdir=$ZPLUGINDIR/${repo:t}
		initfile=$plugdir/${repo:t}.plugin.zsh
		if [[ ! -d $plugdir ]]; then
			echo "Cloning $repo..."
			git clone -q --depth 1 --recursive --shallow-submodules \
				https://github.com/$repo $plugdir
		fi
		if [[ ! -e $initfile ]]; then
			initfiles=($plugdir/*.{plugin.zsh,zsh-theme,zsh,sh}(N))
			(( $#initfiles )) || { echo >&2 "No init file '$repo'." && continue }
			ln -sf $initfiles[1] $initfile
		fi
		fpath+=$plugdir
		(( $+functions[zsh-defer] )) && zsh-defer . $initfile || . $initfile
	done
}

# list of github repos of plugins
repos=(
  Aloxaf/fzf-tab
  zsh-users/zsh-completions
	zsh-users/zsh-autosuggestions
	zsh-users/zsh-history-substring-search
  zsh-users/zsh-syntax-highlighting
	MichaelAquilina/zsh-auto-notify
)
plugin-load $repos

# fzf-tab settings for preview and completion
zstyle ':fzf-tab:*' fzf-flags --height=~40
zstyle ':fzf-tab:complete:*' fzf-preview \
'[[ -d $realpath ]] && eza -1 --tree --level=2 --all --icons=always --color=always $realpath || \
([[ -f $realpath ]] && bat --color=always $realpath || \
echo "Cannot preview")'
setopt glob_dots

# zsh-completions matcher settings
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
_comp_options+=(globdots)

# zsh-auto-notify
export AUTO_NOTIFY_THRESHOLD=30 # Set threshold to 30 seconds
export AUTO_NOTIFY_IGNORE=(
  "nyaa"
  "rb" "hm"
  "fh" "fkill" "fif" "fzf"
  "yy" "sy" "yazi"
  "man" "nvim" "tmux" "tm"
  "lazygit"
)
