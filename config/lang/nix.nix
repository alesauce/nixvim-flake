{
  config = {
    autoCmd = [
      {
        event = "FileType";
        pattern = "nix";
        command = "setlocal tabstop=2 shiftwidth=2 softtabstop=2";
      }
    ];

    plugins = {
      nix.enable = true;
      lsp.servers.nixd.enable = true;
      none-ls.sources = {
        formatting.alejandra.enable = true;
        diagnostics = {
          statix.enable = true;
          deadnix.enable = true;
        };
      };
    };
  };
}
