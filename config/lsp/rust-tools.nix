{
  plugins.rust-tools = {
    enable = true;
    reloadWorkspaceFromCargoToml = true;
    inlayHints = {
      maxLenAlign = true;
    };
  };
}
