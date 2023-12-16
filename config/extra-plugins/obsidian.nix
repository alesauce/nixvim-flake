{
  name = "epwalsh/obsidian.nvim";
  tag = "*";
  lock = false;
  setup = ''
    workspaces = {
      {
        name = "default",
        path = "~/vaults/alesauce-second-brain",
      },
    },
    detect_cwd = false,
    log_level = vim.log.levels.INFO,
    completion = {
      nvim_cmp = true,
      min_chars = 2,
      new_notes_location = "current_dir",
    },
  '';
}
