{
  config,
  lib,
  ...
}: {
  networking.firewall = {
    enable = true;
    allowPing = false;
    rejectPackets = true;

    allowedTCPPorts = config.allTCPPorts;
    allowedTCPPortRanges = config.allTCPPortRanges;
    allowedUDPPortRanges = config.allUDPPortRanges;
    extraCommands = lib.concatStringsSep "\n" config.allExtraCmds;
  };
  # networking.firewall = {
  #   enable = true;
  #   allowPing = false;
  #   rejectPackets = true;
  #
  #   # Allowed services
  #   allowedTCPPorts = lib.mkMerge [
  #     [80 443 53317] # HTTP, HTTPS, Localsend
  #     (lib.mkIf (config.networking.hostName == "vm") [22]) # Add SSH (22) for "vm"
  #   ];
  #   # kdeconnect
  #   allowedTCPPortRanges = [
  #     {
  #       from = 1714; to = 1764;
  #     }
  #   ];
  #   allowedUDPPortRanges = [
  #     {
  #       from = 1714; to = 1764;
  #     }
  #   ];
  #   # SSH with rate limiting (equivalent to iptables rules)
  #   extraCommands = lib.mkMerge [
  #     ''
  #       iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -m limit --limit 3/min --limit-burst 3 -j ACCEPT
  #     ''
  #     (lib.mkIf (config.networking.hostName == "pc") ''
  #       iptables -A INPUT -p tcp --dport 22 -j DROP
  #     '')
  #   ];
  # };
}
