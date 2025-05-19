{
  default = [
    "buffer"
    "copilot"
    "dictionary"
    # "git"
    "lazydev"
    "lsp"
    "path"
    "ripgrep"
    "snippets"
    "cmdline"
  ];

  providers = {
    lsp = {
      name = "LSP";
      module = "blink.cmp.sources.lsp";
      async = false;
      enabled = true;
      max_items = null;
      min_keyword_length = 0;
      override = null;
      score_offset = 4;
      should_show_items = true;
      timeout_ms = 2000;

      fallbacks = [
        "buffer"
      ];
    };
    path = {
      name = "Path";
      module = "blink.cmp.sources.path";
      score_offset = 0;

      fallbacks = [
        "buffer"
      ];

      opts = {
        label_trailing_slash = true;
        show_hidden_files_by_default = false;
        trailing_slash = false;
      };
    };
    buffer = {
      name = "Buffer";
      module = "blink.cmp.sources.buffer";
      score_offset = 0;
    };
    copilot = {
      name = "copilot";
      module = "blink-copilot";
      score_offset = 5;
      async = true;

      opts = {
        max_completions = 3;
        max_attempts = 4;
        kind = "Copilot";
        debounce = 750;
        auto_refresh = {
          backward = true;
          forward = true;
        };
      };
    };
    dictionary = {
      module = "blink-cmp-dictionary";
      name = "Dict";
      min_keyword_length = 3;
      opts = {};
    };
    # git = {
    #   module = "blink-cmp-git";
    #   name = "git";
    #   score_offset = 100;
    #   opts = {
    #     commit = {};
    #     git_centers = {github = {};};
    #   };
    # };
    ripgrep = {
      async = true;
      module = "blink-ripgrep";
      name = "Ripgrep";
      score_offset = 1;
      opts = {
        prefix_min_len = 3;
        context_size = 5;
        max_filesize = "1M";
        project_root_marker = ".git";
        project_root_fallback = true;
        search_casing = "--ignore-case";
        additional_rg_options = {};
        fallback_to_regex_highlighting = true;
        ignore_paths = {};
        additional_paths = {};
        debug = false;
      };
    };
    lazydev = {
      name = "LazyDev";
      module = "lazydev.integrations.blink";
      score_offset = 10;
    };
  };
}
