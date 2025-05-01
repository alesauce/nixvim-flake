{
  plugins = {
    lsp.servers.kotlin_language_server = {
      enable = true;
      settings = {
        kotlin = {
          diagnostics = {
            level = "Information";
          };
          inlayHints = {
            typeHints = true;
            parameterHints = true;
            chainedHints = true;
          };
        };
      };
    };
  };
}
