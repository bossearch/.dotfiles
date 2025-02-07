{ config, pkgs, lib, inputs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.bosse = {
      isDefault = true;
      search = {
        default = "DuckDuckGo";
        privateDefault = "DuckDuckGo";
        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          "NixOS Wiki" = {
            urls = [{ template = "https://wiki.nixos.org/index.php?search={searchTerms}"; }];
            iconUpdateURL = "https://wiki.nixos.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@nw" ];
          };

          "Bing".metaData.hidden = true;
          "Google".metaData.hidden = true; # builtin engines only support specifying one additional alias
        };
      };
      # extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
      #   ublock-origin
      #   sponsorblock
      #   darkreader
      #   fastforwardteam
      #   proton-pass
      #   new-tab-override
      #   side-view
      #   youtube-redux
      #   auto-tab-discard
      # ];
    };
  };

  home.file.".mozilla/firefox/bosse/extensions" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/firefox/extensions";
  };

  home.file.".mozilla/firefox/bosse/user.js" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/firefox/user.js";
  };
  home.file.".mozilla/firefox/bosse/chrome" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/firefox/chrome";
  };
}
