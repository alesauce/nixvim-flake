{
  plugins = {
    cmp-nvim-lsp.enable = true;
    cmp-nvim-lsp-signature-help.enable = true;
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        mapping = {
          "<C-s>" = "cmp.mapping.scroll_docs(-4)";
          "<C-t>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
          "<CR>" = "cmp.mapping.confirm({ select = false })";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        };
        sources = [
          {name = "path";}
          {name = "nvim_lsp";}
          {name = "nvim_lsp_signature_help";}
          {name = "luasnip";}
          {name = "buffer";}
          {name = "tmux";}
          {name = "git";}
        ];
        snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
      };
    };
  };
}
