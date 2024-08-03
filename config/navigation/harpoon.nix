{
  plugins.harpoon = {
    enable = true;
    markBranch = true;

    keymaps = {
      addFile = "<leader>ha";
      toggleQuickMenu = "<leader>hm";
      navNext = "<leader>hn";
      navPrev = "<leader>hp";
      navFile = {
        "1" = "<C-l>";
        "2" = "<C-u>";
        "3" = "<C-y>";
        "4" = "<C-;>";
      };
    };
  };
}
