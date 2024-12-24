#!/bin/bash

# Path to your user.js file
FILE="user.js"

# Declare an associative array to track unique settings and their values
declare -A seen_prefs

# Declare arrays to track duplicates and mismatched values
declare -a duplicate_prefs
declare -a mismatched_prefs

# Read through the file line by line
while IFS= read -r line; do
  # Skip empty lines and comments
  if [[ -z "$line" || "$line" =~ ^\s*// ]]; then
    continue
  fi

  # Check if the line contains user_pref
  if [[ "$line" =~ user_pref\(\"([^\"]+)\"\,\s*(.*)\)\; ]]; then
    setting="${BASH_REMATCH[1]}"
    value="${BASH_REMATCH[2]}"

    # Track duplicates and mismatched values
    if [[ -n "${seen_prefs[$setting]}" ]]; then
      if [[ "${seen_prefs[$setting]}" != "$value" ]]; then
        mismatched_prefs+=("$setting")
      fi
      duplicate_prefs+=("$setting")
    else
      seen_prefs["$setting"]="$value"
    fi
  fi
done <"$FILE"

# Remove duplicates from the duplicate_prefs list
duplicate_prefs=($(printf "%s\n" "${duplicate_prefs[@]}" | sort -u))

# Display the list of duplicates
if [[ ${#duplicate_prefs[@]} -gt 0 ]]; then
  echo "List of duplicate settings:"
  for pref in "${duplicate_prefs[@]}"; do
    echo "- $pref"
  done
else
  echo "No duplicates found."
fi

# Display the list of mismatched values
if [[ ${#mismatched_prefs[@]} -gt 0 ]]; then
  echo
  echo "List of settings with mismatched values:"
  for pref in "${mismatched_prefs[@]}"; do
    echo "- $pref (values: '${seen_prefs[$pref]}' vs other occurrences)"
  done
else
  echo
  echo "No mismatched values found."
fi
