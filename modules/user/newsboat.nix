{pkgs, ...}: {
  programs.newsboat = {
    enable = true;
    browser = "${pkgs.xdg-utils}/bin/xdg-open";
    urls = [
      {
        title = "r/unixporn";
        url = "https://www.reddit.com/r/unixporn.rss";
      }
      {
        title = "r/neovim";
        url = "https://www.reddit.com/r/neovim.rss";
      }
      {
        title = "r/linux";
        url = "https://www.reddit.com/r/linux.rss";
      }
      {
        title = "r/indonesia";
        url = "https://www.reddit.com/r/indonesia.rss";
      }
    ];
    extraConfig = ''
      refresh-on-startup yes
      ignore-mode "display"

      ignore-article "https://www.reddit.com/r/unixporn.rss" \
        "title !~ \"OC\" and \
        title !~ \"Hyprland\" and \
        title !~ \"Awesome\""

      ignore-article "*" "age > 30"

      bind-key ESC quit
      bind-key h quit
      bind-key j down
      bind-key k up
      bind-key l open
      bind-key H prev-feed
      bind-key L next-feed

      color background         default   default
      color listnormal         default   default
      color listnormal_unread  default   default
      color listfocus          black     yellow
      color listfocus_unread   black     yellow
      color info               default   black
      color article            default   default

      # highlights
      highlight article "^(Title):.*$" blue default
      highlight article "https?://[^ ]+" red default
      highlight article "\\[image\\ [0-9]+\\]" green default
    '';
  };
}
