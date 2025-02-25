{
  config,
  pkgs,
  ...
}: {
  programs.firefox = {
    enable = true;
    profiles.bosse = {
      isDefault = true;
      search = {
        default = "DuckDuckGo";
        privateDefault = "DuckDuckGo";
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };

          "Nix Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "channel";
                    value = "24.11";
                  }
                  {
                    name = "from0";
                    value = "";
                  }
                  {
                    name = "size";
                    value = "50";
                  }
                  {
                    name = "sort";
                    value = "relevance";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@no"];
          };

          "NixOS Wiki" = {
            urls = [
              {
                template = "https://wiki.nixos.org/w/index.php";
                params = [
                  {
                    name = "search";
                    value = "{searchTerms}";
                  }
                  {
                    name = "title";
                    value = "Special%3ASearch";
                  }
                  {
                    name = "wprov";
                    value = "acrw1_-1";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";
            definedAliases = ["@nw"];
          };

          "Bing".metaData.hidden = true;
          "Google".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;
        };
        force = true;
      };
      extensions = with pkgs.firefox-addons; [
        proton-pass
        ublock-origin
        new-tab-override
        side-view
        video-downloadhelper
        onetab
        darkreader
        sponsorblock
        unpaywall
      ];
    };
  };

  # home.file.".mozilla/firefox/bosse/extensions" = {
  #   source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/firefox/extensions";
  #   recursive = true;
  # };

  home.file.".mozilla/firefox/bosse/user.js" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/firefox/user.js";
  };
  home.file.".mozilla/firefox/bosse/chrome" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/firefox/chrome";
  };
}
