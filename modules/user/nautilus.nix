{pkgs, ...}: {
  home.packages = with pkgs; [
    sushi
    nautilus
    vaults
  ];
}
