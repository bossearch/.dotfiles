{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.nixvim = {
    diagnostic.settings = {
      virtual_text = true;
      underline = false;
      float = false;
    };
    plugins.lsp = {
      enable = true;
      lazyLoad = {
        settings = {
          event = ["BufReadPre" "BufNewFile"];
        };
      };
      inlayHints = false;
      luaConfig.post = ''
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
          local hl = "DiagnosticSign" .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end
      '';
      servers = {
        nixd = {
          enable = true;
          settings = let
            host = config.spec.hostName;
            user = config.spec.userName;
            flake = ''(builtins.getFlake "github:bossearch/.dotfiles)""'';
          in {
            formatting.command = ["${lib.getExe pkgs.alejandra}"];
            nixpkgs.expr = "import <nixpkgs> {}";
            options = {
              nixos.expr = ''${flake}.nixosConfigurations.${host}.options'';
              home_manager.expr = ''${flake}.homeConfigurations."${user}@${host}".options'';
            };
          };
        };
        bashls = {
          enable = true;
          settings = {
            formatting.command = ["${lib.getExe pkgs.shfmt}"];
          };
        };
        clangd = {
          enable = true;
          settings = {
            # formatting.command = ["${lib.getExe pkgs.clang-tools.clangFormat}"];
            formatting.command = [ "${pkgs.clang-tools}/bin/clang-format" ];
          };
        };
        lua_ls = {
          enable = true;
          settings = {
            formatting.command = ["${lib.getExe pkgs.stylua}"];
          };
        };
      };
    };
  };
}
