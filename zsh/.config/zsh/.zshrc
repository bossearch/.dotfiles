# fzf
source <(fzf --zsh)
export FZF_DEFAULT_OPTS_FILE=~/.config/fzf/.fzfrc
export FZF_{CTRL_T,ALT_C}_OPTS="--preview='~/.config/fzf/fzf-preview.sh {}'"
alias editfzf="nvim ~/.config/fzf/.fzfrc"

# fzf extras #
source ~/.config/fzf/extra/other
#export MANPAGER="sh -c 'col -bx | bat -l man -p --paging always'"
# Check if on Arch Linux
if [ -f /etc/arch-release ]; then
  # Check if fzf is installed
  if command -v fzf &> /dev/null; then
    source ~/.config/fzf/extra/paru
  fi
fi
# Check if tmux is installed
if command -v tmux &> /dev/null; then
  source ~/.config/fzf/extra/tmux
fi

# zoxide
eval "$(zoxide init --cmd cd zsh)"

# thefuck
eval $(thefuck --alias wtf)

# environment variables
export GPG_TTY=$TTY
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=$PATH:/home/bosse/.spicetify
export EDITOR='nvim'

# Move prompt to the bottom
#printf '\n%.0s' {1..$LINES}
#printf "\e[H\ec\e[${LINES}B"

#tput cup $LINES 0
#function bottom_prompt {
#  tput cup $(($LINES-2)) 0
#}
#alias clear="clear &&tput cup $LINES 0"

# shell prompt
#eval "$(starship init zsh)"
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmypost.toml)"

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
#	skywind3000/z.lua
#	romkatv/zsh-defer
  Aloxaf/fzf-tab
	zsh-users/zsh-autosuggestions
	zsh-users/zsh-completions
	zsh-users/zsh-history-substring-search
	zdharma-continuum/fast-syntax-highlighting
	MichaelAquilina/zsh-auto-notify
#	softmoth/zsh-vim-mode
#	kazhala/dotbare
)
plugin-load $repos
autoload -U compinit && compinit

# fzf-tab
zstyle ':fzf-tab:*' fzf-flags --height=~40
zstyle ':fzf-tab:complete:*' fzf-preview \
'[[ -d $realpath ]] && eza -1 --tree --level=2 --all --icons=always --color=always $realpath || \
([[ -f $realpath ]] && bat --color=always $realpath || \
echo "Cannot preview")'
setopt glob_dots
# z.lua
#eval "$(lua ~/.config/zsh/.zlua --init zsh)"

# zsh-completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
#_comp_options+=(globdots)

# zsh-auto-notiy
export AUTO_NOTIFY_THRESHOLD=30 # Set threshold to 30 seconds
export AUTO_NOTIFY_IGNORE=("fkill" "fif" "fzf" "yy" "yazi" "man" "nvim" "tmux" "tm")

# bat-theme
export BAT_THEME="tokyonight_night"

# Keybindings
bindkey -e
#bindkey -M vicmd "^I" fzf
#bindkey '^I' fzf --tmux top
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
#bindkey "^[[A" history-beginning-search-backward
#bindkey "^[[B" history-beginning-search-forward

# vi mode
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

## HISTORY
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }
HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=1200000
SAVEHIST=1000000
HISTDUP=erase
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS

# Aliases
#alias ls='ls --color'
alias ls="eza --color=always --long --git --no-filesize --no-user --icons=always --no-time"
alias pac='sudo pacman'
alias par='paru'
alias execzsh="source ~/.config/zsh/.zshrc"
alias editzsh="nvim ~/.config/zsh/.zshrc"
alias cat=bat

# yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Function to set dynamic title alacritty
## Function to set terminal title to the command being executed
function preexec() {
  local command="$1"
  printf "\e]0;%s\a" "$command"
}

## function to set terminal title to the current directory
function precmd() {
  # only set the title to the current directory if no command is running
  if [[ -z "$zsh_command" || "$zsh_command" == "preexec"* ]]; then
    printf "\e]0;%s\a" "${pwd/#$home/~}"
  fi
}

## register functions
precmd_functions+=(precmd)
preexec_functions+=(preexec)

# remove highlighted '%' symbol on zsh
PROMPT_EOL_MARK=""

# separator line
# Initialize a flag to track first terminal launch
FIRST_PROMPT=true

# Function to print the grey separator line
#separator_line() {
#  # Only show the separator if this isn't the first prompt
#  if [[ "$FIRST_PROMPT" == false ]]; then
#    local cols=$(tput cols)   # Get the width of the terminal
#    local line=$(printf "%0.s -" $(seq 1 $((cols / 2))))
#    
#    # Set grey color using ANSI escape codes
#    local grey='\033[38;5;8m'
#    local reset='\033[0m'
#    
#    # Print the grey line
#    echo -e "${grey}${line}${reset}"
#  fi
#  
#  # Disable the flag after the first prompt
#  FIRST_PROMPT=false
#}
#
#precmd_functions+=(separator_line)
#add-zsh-hook precmd bottom_prompt
