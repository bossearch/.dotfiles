#!/bin/sh

# Output file for the app names and Exec commands
output_file="drun.txt"
rm "$output_file"
touch "$output_file"

# List of apps to exclude (add full .desktop filenames here)
exclude_apps=(
  "Dota 2"
  "Stardew Valley"
  "Steam Linux Runtime 1.0 (scout)"
  "Steam Linux Runtime 2.0 (soldier)"
  "Steam Linux Runtime 3.0 (sniper)"
  "org.prismlauncher.PrismLauncher"
  "waydroid.com.android.calculator2"
  "waydroid.com.android.camera2"
  "waydroid.com.android.contacts"
  "waydroid.com.android.deskclock"
  "waydroid.com.android.documentsui"
  "waydroid.com.android.gallery3d"
  "waydroid.com.android.inputmethod.latin"
  "waydroid.com.android.settings"
  "waydroid.com.android.vending"
  "waydroid.com.aurora.adroid"
  "waydroid.com.aurora.services"
  "waydroid.com.aurora.store"
  "waydroid.com.google.android.gms"
  "waydroid.com.mobile.legends"
  "waydroid.cu.axel.smartdock"
  "waydroid.io.github.huskydg.magisk"
  "waydroid.io.github.sds100.keymapper"
  "waydroid.org.lineageos.eleven"
  "waydroid.org.lineageos.etar"
  "waydroid.org.lineageos.jelly"
  "waydroid.org.lineageos.recorder"
  "waydroid.org.mozilla.firefox"
  "waydroid.app.install"
  "waydroid.market"
  "Waydroid"
  "auto-cpufreq-gtk"
  "avahi-discover"
  "bssh"
  "btop"
  "bvnc"
  "cmake-gui"
  "electron31"
  "electron32"
  "org.gnome.Evince"
  "org.gnome.Evince-previewer"
  "gcr-prompter"
  "gcr-viewer"
  "geoclue-demo-agent"
  "geoclue-where-am-i"
  "gkbd-keyboard-display"
  "google-maps-geo-handler"
  "java-java17-openjdk"
  "java-java21-openjdk"
  "nautilus-autorun-software"
  "nvim"
  "openstreetmap-geo-handler"
  "org.gnupg.pinentry-qt"
  "org.gnupg.pinentry-qt5"
  "polkit-gnome-authentication-agent-1"
  "qv4l2"
  "qvidcap"
  "qwant-maps-geo-handler"
  "steam"
  "wheelmap-geo-handler"
  "org.freedesktop.Xwayland"
  "org.kde.xwaylandvideobridge"
  "yazi"
  "org.gnome.Zenity"
  # Add more apps here that you want to exclude
)

custom_apps=(
  "userapp-alacritty -e nvim-Q1L9T2:nvim"
  "org.cryptomator.Cryptomator:cryptomator"
  "org.gnome.baobab:baobab"
  "org.gnome.Nautilus:nautilus"
  "org.pulseaudio.pavucontrol:pavucontrol"
  "org.shotcut.Shotcut:shotcut"
  "Alacritty:alacritty"
  # Add more apps here that you want to exclude
)

# Custom Exec commands for specific apps
custom_execs=(
  'timeshift-gtk:pkexec env WAYLAND_DISPLAY="$WAYLAND_DISPLAY" XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" GTK_THEME=Tokyonight-Dark timeshift-launcher'
  "mpv:mpv --player-operation-mode=pseudo-gui --input-ipc-server=/tmp/mpv-socket"
  "spotify:spotify"
  "alacritty:alacritty -e bash -c '~/.config/hypr/scripts/assets/alacritty.sh; exec zsh'"
  # Add more custom Exec mappings here
)

# List all .desktop files from standard and Flatpak directories
applications=$(ls /usr/share/applications/*.desktop \
  ~/.local/share/applications/*.desktop \
  /var/lib/flatpak/app/*/current/active/export/share/applications/*.desktop \
  2>/dev/null)

# Process each .desktop file to get name and Exec command
echo "$applications" | while IFS= read -r path; do
  # Extract the base name and remove the .desktop extension
  name=$(basename "$path" .desktop)

  # Skip apps in the exclude list
  if [[ " ${exclude_apps[*]} " =~ " $name " ]]; then
    continue
  fi

  # Change the name for specific apps
  for app in "${custom_apps[@]}"; do
    old_name=$(echo "$app" | cut -d ':' -f 1)
    new_name=$(echo "$app" | cut -d ':' -f 2)
    if [[ "$name" == "$old_name" ]]; then
      name="$new_name"
      break
    fi
  done

  # Extract the Exec command from the .desktop file
  exec_command=$(grep '^Exec=' "$path" | tail -1 | sed 's/^Exec=//' | sed 's/%.*//')

  # Change the Exec command for specific apps
  for exec in "${custom_execs[@]}"; do
    app_name=$(echo "$exec" | cut -d ':' -f 1)
    custom_command=$(echo "$exec" | cut -d ':' -f 2)
    if [[ "$name" == "$app_name" ]]; then
      exec_command="$custom_command"
      break
    fi
  done

  # Skip entries without an Exec command
  if [ -n "$exec_command" ]; then

    if ! grep -q "^$name|" "$output_file"; then
      # Save the name and Exec command to the output file
      echo "$name|$exec_command" >> "$output_file"
    fi
  fi
done

echo "App names and Exec commands saved to $output_file."
