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
        tsserverFilePreferences = {
          quotePreference = "single";
          includeCompletionsWithClassMemberSnippets = true;
          # Inlay Hints
          includeInlayParameterNameHints = "all";
          includeInlayParameterNameHintsWhenArgumentMatchesName = true;
          includeInlayFunctionParameterTypeHints = true;
          includeInlayVariableTypeHints = true;
          includeInlayVariableTypeHintsWhenTypeMatchesName = true;
          includeInlayPropertyDeclarationTypeHints = true;
          includeInlayFunctionLikeReturnTypeHints = true;
          includeInlayEnumMemberValueHints = true;
        };
        tsserverFormatOptions = {
          semicolons = "insert";
        };
      };
    };
  };
}
