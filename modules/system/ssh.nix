{lib, ...}: {
  services.openssh = {
    enable = lib.mkForce true;
    settings = {
      PasswordAuthentication = false; # Disable password authentication (recommended for security)
      PermitRootLogin = "prohibit-password"; # Disallow root login over SSH
    };
  };
}
