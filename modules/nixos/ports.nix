{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;

  ports = config.port;

  declaredTCPPorts = lib.concatLists (map (p: p.TCPPorts or []) ports);
  declaredUDPPorts = lib.concatLists (map (p: p.UDPPorts or []) ports);
  declaredTCPPortRanges = lib.concatLists (map (p: p.TCPPortsRanges or []) ports);
  declaredUDPPortRanges = lib.concatLists (map (p: p.UDPPortsRanges or []) ports);
  declaredExtraCmds = lib.filter (x: x != null && x != "") (map (p: p.extra or null) ports);
in {
  options = {
    port = mkOption {
      type = types.listOf (
        types.submodule {
          options = {
            TCPPorts = mkOption {
              type = types.listOf types.port;
              default = [];
              description = "Allowed individual TCP ports.";
            };
            UDPPorts = mkOption {
              type = types.listOf types.port;
              default = [];
              description = "Allowed individual UDP ports.";
            };
            TCPPortsRanges = mkOption {
              type = types.listOf (
                types.submodule {
                  options = {
                    from = mkOption {type = types.port;};
                    to = mkOption {type = types.port;};
                  };
                }
              );
              default = [];
              description = "TCP port ranges.";
            };
            UDPPortsRanges = mkOption {
              type = types.listOf (
                types.submodule {
                  options = {
                    from = mkOption {type = types.port;};
                    to = mkOption {type = types.port;};
                  };
                }
              );
              default = [];
              description = "UDP port ranges.";
            };
            extra = mkOption {
              type = types.str;
              default = ''
                iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW \
                -m limit --limit 3/min --limit-burst 3 -j ACCEPT
              '';
              description = "Extra iptables commands.";
            };
          };
        }
      );
      default = [];
      description = "Declarative firewall port and iptables entries.";
    };

    allTCPPorts = mkOption {
      type = types.listOf types.port;
      readOnly = true;
      default = declaredTCPPorts;
      description = "Merged list of all TCP ports.";
    };

    allUDPPorts = mkOption {
      type = types.listOf types.port;
      readOnly = true;
      default = declaredUDPPorts;
      description = "Merged list of all UDP ports.";
    };

    allTCPPortRanges = mkOption {
      type = types.listOf (types.attrsOf types.port);
      readOnly = true;
      default = declaredTCPPortRanges;
      description = "Merged list of all TCP port ranges.";
    };

    allUDPPortRanges = mkOption {
      type = types.listOf (types.attrsOf types.port);
      readOnly = true;
      default = declaredUDPPortRanges;
      description = "Merged list of all UDP port ranges.";
    };

    allExtraCmds = mkOption {
      type = types.listOf types.str;
      readOnly = true;
      default = declaredExtraCmds;
      description = "List of iptables commands.";
    };
  };
}
