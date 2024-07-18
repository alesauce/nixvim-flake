{
  config = {
    autoCmd = [
      {
        event = "FileType";
        pattern = "typescript";
        command = "setlocal tabstop=2 shiftwidth=2";
      }
    ];

    plugins.typescript-tools = {
      enable = true;
      settings = {
        codeLens = "off";
        completeFunctionCalls = true;
        includeCompletionsWithInsertText = true;
        separateDiagnosticServer = true;
        tsserverFormatOptions = {
          quotePreference = "single";
        };
      };
    };
  };
}
