#!/bin/bash

# Path to your user.js file
FILE="user.js"

# Declare an associative array to track unique settings
declare -A seen_prefs

# Declare an array to track duplicates
declare -a duplicate_prefs

# Read through the file line by line
while IFS= read -r line; do
  # Skip empty lines and comments
  if [[ -z "$line" || "$line" =~ ^\s*// ]]; then
    continue
  fi

  # Check if the line contains user_pref
  if [[ "$line" =~ user_pref\(\"([^\"]+)\" ]]; then
    setting="${BASH_REMATCH[1]}"

    # Track duplicates
    if [[ -n "${seen_prefs[$setting]}" ]]; then
      duplicate_prefs+=("$setting")
    else
      seen_prefs["$setting"]=1
    fi
  fi
done <"$FILE"

# Display the list of duplicates
if [[ ${#duplicate_prefs[@]} -gt 0 ]]; then
  echo "List of duplicate settings:"
  for pref in "${duplicate_prefs[@]}"; do
    echo "- $pref"
  done
else
  echo "No duplicates found."
fi
