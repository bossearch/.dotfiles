{config, ...}: let
  host = config.spec.hostName;
  user = config.spec.userName;
in {
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
          settings = {
            formatting.command = ["alejandra"];
            nixpkgs.expr = "import <nixpkgs> {}";
            options = {
              nixos.expr = ''(builtins.getFlake "/home/${user}/.dotfiles").nixosConfigurations.${host}.options'';
              home_manager.expr = ''(builtins.getFlake "/home/${user}/.dotfiles").homeConfigurations."${user}@${host}".options'';
            };
          };
        };
        bashls = {
          enable = true;
          settings = {
            formatting.command = ["shfmt"];
          };
        };
        clangd = {
          enable = true;
          settings = {
            formatting.command = ["clang-format"];
          };
        };
        lua_ls = {
          enable = true;
          settings = {
            formatting.command = ["stylua"];
          };
        };
      };
    };
  };
}
