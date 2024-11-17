{
  config = {
    extraConfigLuaPre = ''
      _M.workspace_root_dir = vim.fs.root("Config", { "packageInfo" })
      _M.bemol_ws_folders = {}
      if _M.workspace_root_dir then
       local file = io.open(_M.workspace_root_dir .. "/.bemol/ws_root_folders", "r")
       if file then
        for line in file:lines() do
         table.insert(_M.bemol_ws_folders, "file://" .. line)
        end
        file:close()
       end
      end

      function bemol()
       for _, line in ipairs(_M.bemol_ws_folders) do
        vim.lsp.buf.add_workspace_folder(line)
       end
      end
    '';

    plugins = {
      lsp = {
        enable = true;
        servers = {
          gopls.enable = true;
          jsonls.enable = true;
          lua_ls.enable = true;
          pyright.enable = true;
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
            "<leader>ft" = "format";
          };
        };
      };
      lspkind = {
        enable = true;
      };
    };
    extraConfigLuaPost = ''
      bemol()
    '';
  };
}
