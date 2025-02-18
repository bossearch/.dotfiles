{pkgs, ...}: let
  automatedusbguard = pkgs.writeScript "automatedusbguard.sh" ''
    #!${pkgs.bash}/bin/bash
    export DISPLAY=:0
    export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

    DEVICE_PATH="$1"
    LOCKFILE="/tmp/usbguard_lock_$1"  # Use device ID for unique lockfile

    # Prevent duplicate prompts for the same device
    if [ -e "$LOCKFILE" ]; then
      exit 0
    fi

    touch "$LOCKFILE"

    # Get the device name using udevadm
    DEVICE_NAME=$(udevadm info --query=property --name="$DEVICE_PATH" | grep -i "ID_MODEL=" | cut -d= -f2)
    DEVICE_VENDOR=$(udevadm info --query=property --name="$DEVICE_PATH" | grep -i "ID_VENDOR=" | cut -d= -f2)

    # If the device name is not found, fall back to using the device path
    if [ -z "$DEVICE_NAME" ]; then
      DEVICE_NAME="$DEVICE_PATH"
    fi

    # Show Zenity dialog
    choice=$(/run/wrappers/bin/su bosse -c "${pkgs.zenity}/bin/zenity --question \
      --text='Do you trust the $DEVICE_VENDOR $DEVICE_NAME device?' --title='New Device Detected' \
      --ok-label='Allow' --cancel-label='Block'")

    if [ $? -eq 0 ]; then
      /run/wrappers/bin/pkexec /home/bosse/.dotfiles/scripts/automate-usbguard.sh -t
    else
      :
    fi

    # Clean up after processing
    rm -f "$LOCKFILE"
  '';
in {
  services.udev = {
    enable = true;
    extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", ENV{DEVNAME}!="", RUN+="${automatedusbguard} $env{DEVNAME}"
    '';
  };
}
