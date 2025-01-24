# ----------------------------
# Environment Variables & Basics
# ----------------------------

# Initialize completion
autoload -U compinit && compinit

# Set terminal-related environment variables
export GPG_TTY=$TTY
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=$PATH:/home/bosse/.spicetify
export EDITOR='nvim'
export BAT_THEME="tokyonight_night"
export AUTO_NOTIFY_THRESHOLD=30 # Set threshold to 30 seconds
export AUTO_NOTIFY_IGNORE=("nyaa" "fman" "fh" "fkill" "fif" "fzf" "yy" "sy" "yazi" "man" "nvim" "tmux" "tm")

# bat-theme
# ----------------------------
# Plugins, Extras & Initialization
# ----------------------------

# Load fzf and its related configurations
source <(fzf --zsh)
export FZF_DEFAULT_OPTS_FILE=~/.config/fzf/.fzfrc
export FZF_{CTRL_T,ALT_C}_OPTS="--preview='~/.config/fzf/extra/fzf-preview.sh {}'"

# Source additional fzf extras
source ~/.config/fzf/extra/other

# Arch Linux specific setup for fzf if installed
if [ -f /etc/arch-release ]; then
  if command -v fzf &> /dev/null; then
    source ~/.config/fzf/extra/paru
  fi
fi

# Check if tmux is installed and load tmux settings
if command -v tmux >/dev/null 2>&1; then
  source ~/.config/fzf/extra/tmux
fi

# Zoxide initialization
eval "$(zoxide init --cmd cd zsh)"

# Thefuck initialization
eval $(thefuck --alias wtf)

# ----------------------------
# Shell Prompt and Theme
# ----------------------------

# Initialize Oh My Posh with custom config
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmypost.toml)"

# ----------------------------
# Plugins (via zplug)
# ----------------------------

# Define Zinit home location and clone if not present
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# Add the compatibility snippet for compinit directly to zinit.zsh if it's the first time installing
if [ -f "${ZINIT_HOME}/zinit.zsh" ]; then
    echo 'autoload -Uz _zinit' >> "${ZINIT_HOME}/zinit.zsh"
    echo '(( ${+_comps} )) && _comps[zinit]=_zinit' >> "${ZINIT_HOME}/zinit.zsh"
fi

# Source zinit
source "${ZINIT_HOME}/zinit.zsh"

#  Plugin loading function
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-history-substring-search
zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice wait"2" MichaelAquilina/zsh-auto-notify
zinit ice wait"2" Aloxaf/fzf-tab

# ----------------------------
# fzf-tab Configuration
# ----------------------------

# fzf-tab settings for preview and completion
zstyle ':fzf-tab:*' fzf-flags --height=~40
zstyle ':fzf-tab:complete:*' fzf-preview \
'[[ -d $realpath ]] && eza -1 --tree --level=2 --all --icons=always --color=always $realpath || \
([[ -f $realpath ]] && bat --color=always $realpath || \
echo "Cannot preview")'
setopt glob_dots

# ----------------------------
# zsh-completions Settings
# ----------------------------

# zsh-completions matcher settings
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
_comp_options+=(globdots)

# ----------------------------
# History Configuration
# ----------------------------

# History settings for zsh
HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=1200000
SAVEHIST=1000000
HISTDUP=erase
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS

# Function to add commands to history
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

# ----------------------------
# Keybindings
# ----------------------------

# Bind keys for search and history navigation
bindkey -e
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Vi mode setup for visual/insert modes
export KEYTIMEOUT=1
zle-keymap-select () {
    if [[ $KEYMAP == vicmd ]]; then
        echo -ne "\e[2 q"
    else
        echo -ne "\e[5 q"
    fi
}
precmd_functions+=(zle-keymap-select)
zle -N zle-keymap-select

# ----------------------------
# Aliases
# ----------------------------

# Aliases for convenience
alias ls="eza --color=always --long --git --no-filesize --no-user --icons=always --no-time"
alias pac='sudo pacman'
alias par='paru'
alias editzsh="nvim ~/.config/zsh/.zshrc"
alias e="nvim"
alias c="clear"
alias cat=bat
# alias sy='sudo -E yazi'

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
    local tmp="/tmp/yazi-cwd.XXXXXX"
    sudo -E yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    sudo rm -f -- "$tmp"
}
