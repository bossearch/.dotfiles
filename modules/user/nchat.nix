{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with inputs.nixpkgs-unstable.legacyPackages.x86_64-linux; [
    nchat
  ];

  home.file.".config/nchat/app.conf" = {
    source = ./../../configs/nchat/app.conf;
  };

  home.file.".config/nchat/color.conf" = {
    source = ./../../configs/nchat/color.conf;
  };

  home.file.".config/nchat/key.conf" = {
    source = ./../../configs/nchat/key.conf;
  };

  home.file.".config/nchat/ui.conf" = {
    source = ./../../configs/nchat/ui.conf;
  };

  home.file.".config/nchat/usercolor.conf" = {
    source = ./../../configs/nchat/usercolor.conf;
  };
}
