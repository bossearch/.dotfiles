#!/bin/sh

# List all .desktop files from standard and Flatpak directories
applications=$(ls /usr/share/applications/*.desktop \
  ~/.local/share/applications/*.desktop \
  /var/lib/flatpak/app/*/current/active/export/share/applications/*.desktop \
  2>/dev/null)

# Use basename to only show filenames without extension in fzf
selected=$(echo "$applications" | xargs -I{} basename {} | sed 's/\.desktop$//' | sort | \
  fzf -m --no-sort --layout=default --border=none --highlight-line --info=inline-right --prompt="❯ "\
  --color=fg:#c0caf5,fg+:#B1BAE4,bg:#1a1b26,bg+:#16161e,hl:#92BE67,hl+:#93d84e\
  --color=info:#7296E6,marker:#E26E87,prompt:#AC8FE6,spinner:#E26E87,pointer:#E26E87\
  --color=gutter:#1a1b26,separator:#27a1b9,scrollbar:#27a1b9,label:#aeaeae,query:#B1BAE4\
)

# Process each selected .desktop file
while IFS= read -r file; do
  if [ -n "$file" ]; then
    # Find the full path of the selected .desktop file
    full_path=$(echo "$applications" | grep "/$file.desktop$")

    # Extract the command from the Exec line in the .desktop file
    extract=$(grep '^Exec=' "$full_path" | tail -1 | sed 's/^Exec=//' | sed 's/%.*//')

    # Run the command
    echo "$extract" | xargs -r -I {} sh -c 'nohup {} >/dev/null 2>&1 & disown'
  fi
done <<< "$selected"

