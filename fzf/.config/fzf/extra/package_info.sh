#!/bin/bash

output_file="$HOME/.config/fzf/extra/output.txt" # Specify your desired output file path

# Arguments passed from the function
name="$1"
repo="$2"
arch="$3"

# Write extracted values to the output file
{
  echo "Repo: $repo"
  echo "Name: $name"
  echo "Arch: $arch"

  if [[ "$repo" == "core" || "$repo" == "extra" || "$repo" == "multilib" ]]; then
    url="https://archlinux.org/packages/$repo/$arch/$name"
  elif [[ "$repo" == "aur" ]]; then
    url="https://aur.archlinux.org/packages/$name"
  else
    url="Unknown repository"
  fi

  echo "URL: $url"
} >"$output_file"

# Open the URL if it's valid
if [[ -n "$url" && "$url" != "Unknown repository" ]]; then
  xdg-open "$url"
else
  notify-send "No valid URL to open."
  echo "No valid URL to open." >>"$output_file"
fi
