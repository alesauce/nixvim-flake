{
  plugins.nvim-tree = {
    enable = true;
    disableNetrw = true;
    autoReloadOnWrite = true;
    hijackNetrw = true;
    hijackUnnamedBufferWhenOpening = true;
    sortBy = "case_sensitive";

    filesystemWatchers.enable = true;
  };
  keymaps = [
    {
      key = "<leader>nt";
      action = ":NvimTreeFocus<CR>";
    }
  ];
}
