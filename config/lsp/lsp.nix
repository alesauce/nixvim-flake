{
  plugins = {
    lsp = {
      enable = true;
      servers = {
        bashls.enable = true;
        gopls.enable = true;
        jsonls.enable = true;
        lua-ls.enable = true;
        nil_ls.enable = true;
        pyright.enable = true;
        tsserver.enable = true;
        yamlls.enable = true;
      };
      keymaps = {
        silent = true;
        diagnostic = {
          "<leader>f" = "open_float";
          "[d" = "goto_prev";
          "]d" = "goto_next";
          "<leader>q" = "setloclist";
        };
        lspBuf = {
          "gD" = "declaration";
          "gd" = "definition";
          "K" = "hover";
          "gi" = "implementation";
          "<C-k>" = "signature_help";
          "<leader>rn" = "rename";
          "gr" = "references";
        };
      };
    };
    lspkind = {
      enable = true;
    };
    none-ls.enable = true;
  };
}
