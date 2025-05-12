{...}: {
  home.file.".config/fzf/extra/drun.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Read the app names and Exec commands from the saved txt file
      apps_list=$(cat "$HOME/.cache/bosse/drun.txt")

      # Use fzf to list app names and select multiple
      selected=$(
        echo "$apps_list" | cut -d'|' -f1 | sort |
          fzf -m --layout=default --border=none --highlight-line --info=inline-right --prompt="❯ " \
            --color=fg:#c0caf5,fg+:#B1BAE4,bg:#1a1b26,bg+:#16161e,hl:#92BE67,hl+:#93d84e \
            --color=info:#7296E6,marker:#E26E87,prompt:#AC8FE6,spinner:#E26E87,pointer:#E26E87 \
            --color=gutter:#1a1b26,separator:#27a1b9,scrollbar:#27a1b9,label:#aeaeae,query:#B1BAE4 \
            --bind 'tab:select+backward-kill-word'
      )

      # Run each selected application's Exec command
      while IFS= read -r app; do
        if [ -n "$app" ]; then
          exec_command=$(echo "$apps_list" | grep "^$app|" | cut -d'|' -f2)
          setsid bash -c "$exec_command" >/dev/null 2>&1 & disown
        fi
      done <<< "$selected"

      sleep 0.1
    '';
  };
}
