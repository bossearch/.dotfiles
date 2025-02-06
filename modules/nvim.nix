{ config, pkgs, ... }:
{

  home.packages = with pkgs; [
    libgcc
    llvmPackages_19.libcxxClang
    nodejs_23
    python39
    cmake
    gnumake42
  ];

  home.file.".config/nvim" = {
    source = ./../configs/nvim;
  };

}
