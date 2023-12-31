{
  plugins.rust-tools = {
    enable = true;
    reloadWorkspaceFromCargoToml = true;
    inlayHints = {
      maxLenAlign = true;
    };
    server = {
      checkOnSave = true;
      cachePriming.enable = true;
      completion = {
        autoimport.enable = true;
        fullFunctionSignatures.enable = true;
      };
    };
  };
}
