{
  config,
  lib,
  ...
}: {
  networking.firewall = {
    enable = true;
    allowPing = false;
    rejectPackets = true;

    # Allowed services
    allowedTCPPorts = lib.mkMerge [
      [80 443 53317] # HTTP, HTTPS, Localsend
      (lib.mkIf (config.networking.hostName == "vm") [22]) # Add SSH (22) for "vm"
    ];
    # SSH with rate limiting (equivalent to iptables rules)
    extraCommands = ''
      iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -m limit --limit 3/min --limit-burst 3 -j ACCEPT
      iptables -A INPUT -p tcp --dport 22 -j DROP
    '';
  };
}
