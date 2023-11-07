{
  plugins = {
    nvim-cmp = {
      enable = true;
      sources = [
        {name = "path";}
        {name = "nvim_lsp";}
        {name = "nvim_lsp_signature_help";}
        {name = "luasnip";}
        {name = "buffer";}
      ];
      mapping = {
        "<C-s>" = "cmp.mapping.scroll_docs(-4)";
        "<C-t>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.abort()";
        "<CR>" = "cmp.mapping.confirm({ select = false })";
        "<Tab>" = {
          action = "cmp.mapping.select_next_item()";
          modes = ["i" "s"];
        };
        "<S-Tab>" = {
          action = "cmp.mapping.select_prev_item()";
          modes = ["i" "s"];
        };
      };
      snippet.expand = "luasnip";
    };
  };
}
