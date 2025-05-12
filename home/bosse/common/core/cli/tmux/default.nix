{pkgs, ...}: {
  imports = [
    ./theme
  ];
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    extraConfig = ''
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      # Tmux config
      set -s set-clipboard on
      set -g mouse on
      set -g set-titles on
      set -g allow-passthrough on
      set-option -g status-position top

      # Tmux sensible
      set -g status-interval 1
      set -g status-keys vi
      set -g history-limit 10000
      set -g focus-events on

      # Theme
      # Date and Time
      set -g @tokyo-night-tmux_show_datetime 0
      set -g @tokyo-night-tmux_date_format MYD
      set -g @tokyo-night-tmux_time_format 12H
      # Path
      set -g @tokyo-night-tmux_show_path 0
      set -g @tokyo-night-tmux_path_format relative # 'relative' or 'full'
      # Music
      set -g @tokyo-night-tmux_show_music 0
      # Net
      set -g @tokyo-night-tmux_show_netspeed 1
      set -g @tokyo-night-tmux_netspeed_iface "enp5s0" # Detected via default route
      set -g @tokyo-night-tmux_netspeed_showip 0
      set -g @tokyo-night-tmux_netspeed_refresh 1     # Update interval in seconds (default 1)
      # Hostname
      set -g @tokyo-night-tmux_show_hostname 1

      # bindkey
      unbind Up
      unbind Down
      unbind Left
      unbind Right
      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R
      bind -r Left resize-pane -L    # Resize pane to the left
      bind -r Down resize-pane -D    # Resize pane downward
      bind -r Up resize-pane -U      # Resize pane upward
      bind -r Right resize-pane -R   # Resize pane to the right
      bind -n M-h previous-window
      bind -n M-l next-window

      # Split
      unbind %
      unbind '"'
      bind | split-window -h
      bind - split-window -v

      # Selection mode
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection
      unbind -T copy-mode-vi MouseDragEnd1Pane

      # Fzf
      unbind Space
      unbind q
      bind Space popup -E -B -w80 -h10 -xC -y38.5  "zsh -ci ftpane"
      bind Tab popup -E -B -w80 -h10 -xC -y38.5  "zsh -ci tm"
      bind Escape popup -E -B -w80 -h10 -xC -y38.5  "zsh -ci ftpanekill"
      bind q popup -E -B -w80 -h10 -xC -y38.5  "zsh -ci tmuxkill"
      bind Enter popup -E -w100 -h50 -xC -yC

      run-shell ~/.config/tmux/plugins/theme/theme.tmux
    '';
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
        extraConfig = ''
          set -g @vim_navigator_mapping_left "C-Left C-h"  # use C-h and C-Left
          set -g @vim_navigator_mapping_right "C-Right C-l"
          set -g @vim_navigator_mapping_up "C-k"
          set -g @vim_navigator_mapping_down "C-j"
          set -g @vim_navigator_mapping_prev ""  # removes the C-\ binding
        '';
      }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
    ];
  };
}
