{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nyaa.homeManagerModule
  ];

  home.packages = with pkgs; [
    transmission_4-gtk
  ];

  programs.nyaa = {
    enable = true;
    default_source = "Nyaa";
    download_client = "Transmission";
    timeout = 30;
    scroll_padding = 3;
    cursor_padding = 4;
    client.transmission = {
      base_url = "http://localhost:9091/transmission/rpc";
      username = "bosse";
      password_file = "/home/bosse/Documents/obsidian-vault/05 - Permanent/transmission-password.md";
      use_magnet = true;
      download_dir = "/home/bosse/Videos/Anime/";
    };
  };
}
