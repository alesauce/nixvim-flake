{
  plugins.rust-tools = {
    enable = true;
    reloadWorkspaceFromCargoToml = true;
    inlayHints = {
      maxLenAlign = true;
    };
    server = {
      checkOnSave = true;
      completion = {
        autoimport.enable = true;
        fullFunctionSignatures.enable = true;
      };
    };
  };
}
