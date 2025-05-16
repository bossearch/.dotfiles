{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    keymaps = [
      # buffers
      {
        action = "<cmd>bprevious<cr>";
        key = "<S-h>";
        options = {
          silent = true;
          noremap = true;
          desc = "Prev Buffer";
        };
      }
      {
        action = "<cmd>bnext<cr>";
        key = "<S-l>";
        options = {
          silent = true;
          noremap = true;
          desc = "Next Buffer";
        };
      }
      # diagnostic
      {
        action.__raw = ''
          function()
            vim.diagnostic.goto_next({float=false})
          end
        '';
        key = "<S-j>";
        options = {
          silent = true;
          noremap = true;
          desc = "Next Diagnostic";
        };
      }
      {
        action.__raw = ''
          function()
            vim.diagnostic.goto_prev({float=false})
          end
        '';
        key = "<S-k>";
        options = {
          silent = true;
          noremap = true;
          desc = "Prev Diagnostic";
        };
      }
      # undo break-points
      {
        action = ",<c-g>u";
        key = ",";
        mode = "i";
      }
      {
        action = ".<c-g>u";
        key = ".";
        mode = "i";
      }
      {
        action = ";<c-g>u";
        key = ";";
        mode = "i";
      }
      # sessions
      {
        action.__raw = ''
          function()
            require("mini.sessions").write("global-session")
            print("Session saved!")
          end
        '';
        key = "<C-s>";
        mode = ["n" "v" "i"];
        options = {
          silent = true;
          noremap = true;
          desc = "Prev Buffer";
        };
      }
    ];
  };
}
