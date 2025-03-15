{pkgs, ...}: {
  programs.newsboat = {
    enable = true;
    browser = "${pkgs.xdg-utils}/bin/xdg-open";
    urls = [
      {
        title = "r/linux";
        tags = ["Reddit" "Interest"];
        url = "https://www.reddit.com/r/linux.rss !";
      }
      {
        title = "r/unixporn";
        tags = ["Reddit" "Interest"];
        url = "https://www.reddit.com/r/unixporn.rss !";
      }
      {
        title = "r/neovim";
        tags = ["Reddit" "Interest"];
        url = "https://www.reddit.com/r/neovim.rss !";
      }
      {
        title = "r/NixOS";
        tags = ["Reddit" "Interest"];
        url = "https://www.reddit.com/r/NixOS.rss !";
      }
      {
        title = "r/gaming";
        tags = ["Reddit" "Games"];
        url = "https://www.reddit.com/r/gaming.rss !";
      }
      {
        title = "r/DotA2";
        tags = ["Reddit" "Games"];
        url = "https://www.reddit.com/r/DotA2.rss !";
      }
      {
        title = "r/Minecraft";
        tags = ["Reddit" "Games"];
        url = "https://www.reddit.com/r/Minecraft.rss !";
      }
      {
        title = "r/MinecraftMemes";
        tags = ["Reddit" "Memes"];
        url = "https://www.reddit.com/r/MinecraftMemes.rss !";
      }
      {
        title = "r/indonesia";
        tags = ["Reddit" "Local"];
        url = "https://www.reddit.com/r/indonesia.rss !";
      }
    ];
    queries = {
      Reddit = "tags =~ \"Reddit\"";
      Interest = "tags =~ \"Interest\"";
      Games = "tags =~ \"Games\"";
      Memes = "tags =~ \"Memes\"";
      Local = "tags =~ \"Local\"";
    };
    extraConfig = ''
      macro i set browser "~/.config/newsboat/preview.sh %u"
      show-title-bar no
      refresh-on-startup yes
      prepopulate-query-feeds yes

      ignore-mode "display"
      ignore-article "*" "age > 7"
      ignore-article "https://www.reddit.com/r/unixporn.rss" \
        "title !~ \"OC\" and \
        title !~ \"Hyprland\" and \
        title !~ \"Awesome\""

      bind-key ESC quit
      bind-key h quit
      bind-key j down
      bind-key k up
      bind-key l open
      bind-key H prev-feed
      bind-key L next-feed
      bind-key o open-in-browser-and-mark-read

      color listnormal         color15 default
      color listnormal_unread  color2  default
      color listfocus_unread   color2  color0
      color listfocus          default color0
      color background         default default
      color article            default default
      color end-of-text-marker color8  default
      color info               color4  color8
      color hint-separator     default color8
      color hint-description   default color8
      color title              color14 color8

      # highlights
      highlight all "---.*---" yellow
      highlight feedlist ".*(0/0))" black
      highlight article "(^Feed:|^Title:|^Date:|^Link:|^Author:)" cyan default bold
      highlight article "https?://[^ ]+" yellow default
      highlight article "\\[[0-9][0-9]*\\]" magenta default bold
      highlight article "\\[image\\ [0-9]+\\]" green default bold
      highlight article "\\[embedded flash: [0-9][0-9]*\\]" green default bold
      highlight article ":.*\\(link\\)$" cyan default
      highlight article ":.*\\(image\\)$" blue default
      highlight article ":.*\\(embedded flash\\)$" magenta default
    '';
  };
  xdg.desktopEntries.newsboat = {
    type = "Application";
    name = "newsboat";
    exec = "kitty -T newsboat newsboat";
    comment = "Open newsboat with kitty";
  };
}
