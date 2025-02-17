{pkgs, ...}: let
  hidDeviceNotificationScript = pkgs.writeScript "hid-notification.sh" ''
    #!${pkgs.bash}/bin/bash
    export DISPLAY=:0
    export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"
    /run/wrappers/bin/su bosse -c "${pkgs.libnotify}/bin/notify-send -e -t 86400000 -u critical 'Security Alert' 'Unknown HID device detected!'"
  '';
in {
  environment.systemPackages = with pkgs; [
    udev-block-notify
  ];
  # Add the udev rule to trigger the script when a new HID device is detected
  services.udev = {
    enable = true;
    extraRules = ''
      ACTION=="add",SUBSYSTEM=="hidraw", RUN+="${hidDeviceNotificationScript}"
    '';
  };
}
