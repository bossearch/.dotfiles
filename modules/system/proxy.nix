{pkgs, ...}: {
  programs.proxychains = {
    enable = true;
    package = pkgs.proxychains-ng;
    proxyDNS = true;
    tcpReadTimeOut = 15000;
    tcpConnectTimeOut = 8000;

    # Define proxies
    proxies = {
      denver = {
        enable = true;
        type = "socks5";
        host = "139.64.165.22";
        port = 1080;
      };
    };

    # Proxy chaining configuration
    chain = {
      type = "strict"; # Options: "strict", "dynamic", "random"
      # length = 2; # Number of proxies in the chain (only for dynamic)
    };
  };
}
