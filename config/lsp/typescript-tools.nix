{
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
}
