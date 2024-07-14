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
      # TODO: add none-ls sources
    };
  };
}
