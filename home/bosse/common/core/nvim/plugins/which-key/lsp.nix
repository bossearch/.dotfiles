[
  # LSP
  {
    __unkeyed = "<leader>l";
    group = "LSP";
    icon = " ";
    mode = "n";
  }
  {
    __unkeyed = "<leader>lf";
    __unkeyed-1.__raw = ''
      function()
        vim.lsp.buf.format({
          async = false,
          timeout_ms = 500,
        })
      end
    '';
    desc = "Format File";
    mode = ["n" "v"];
  }
]
