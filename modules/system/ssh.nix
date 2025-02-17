{...}: {
  services.openssh = {
    enable = true;
    passwordAuthentication = false; # Disable password authentication (recommended for security)
    permitRootLogin = "prohibit-password"; # Disallow root login over SSH
  };
}
