#!/bin/sh

# List all executables from PATH
executables=$(find -L $(echo $PATH | tr ':' ' ') -type f -executable -printf "%f\n" | sort -u)

# Use fzf to select multiple commands
selected=$(echo "$executables" | fzf -m --no-sort --highlight-line --info=inline-right --prompt="❯ "\
  --color=fg:#c0caf5,fg+:#B1BAE4,bg:#1a1b26,bg+:#16161e,hl:#92BE67,hl+:#93d84e\
  --color=info:#7296E6,marker:#E26E87,prompt:#AC8FE6,spinner:#E26E87,pointer:#E26E87\
  --color=gutter:#1a1b26,separator:#27a1b9,scrollbar:#27a1b9,label:#aeaeae,query:#B1BAE4\
)

# Process each selected command
while IFS= read -r command; do
  if [ -n "$command" ]; then

    # Run the selected command
    echo "$command" | xargs -r -I {} sh -c 'nohup {} >/dev/null 2>&1 & disown'
  fi
done <<< "$selected"
