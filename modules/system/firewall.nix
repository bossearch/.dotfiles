{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    nixos-firewall-tool
  ];

  networking.firewall = {
    enable = true;
    # Default policy: Drop all incoming traffic unless explicitly allowed
    allowPing = false;
    rejectPackets = true;

    # Allowed services
    allowedTCPPorts = [80 443 53317]; # HTTP, HTTPS, and Localsend

    # SSH with rate limiting (equivalent to iptables rules)
    extraCommands = ''
      iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -m limit --limit 3/min --limit-burst 3 -j ACCEPT
      iptables -A INPUT -p tcp --dport 22 -j DROP
    '';
  };
}
