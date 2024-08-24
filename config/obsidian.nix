{
  plugins.obsidian = {
    enable = true;
    settings = {
      disable_frontmatter = true;
      log_level = "info";
      open_notes_in = "vsplit";
      preferred_link_style = "wiki";
      sort_by = "modified";
      sort_reversed = true;
      templates.subdir = "_templates";
      completion = {
        min_chars = 2;
        nvim_cmp = true;
      };
      daily_notes = {
        folder = "logs";
      };
      picker.name = "telescope.nvim";
      workspaces = [
        {
          name = "main";
          path = "~/vaults/second-brain";
        }
        {
          name = "recipes";
          path = "~/vaults/recipes";
        }
      ];
      ui = {
        enable = true;
      };
    };
  };

  keymaps = [
    {
      key = "<leader>oq";
      action = ":ObsidianQuickSwitch<CR>";
      options = {
        noremap = true;
        desc = "Obsidian quick switcher";
      };
    }
    {
      key = "<leader>on";
      action = ":ObsidianNew<CR>";
      options = {
        noremap = true;
        desc = "Obsidian create new note";
      };
    }
    {
      key = "<leader>ob";
      action = ":ObsidianBacklinks<CR>";
      options = {
        noremap = true;
        desc = "Backlinks to current note";
      };
    }
    {
      key = "<leader>ot";
      action = ":ObsidianToday<CR>";
      options = {
        noremap = true;
        desc = "Open/create daily note";
      };
    }
    {
      key = "<leader>os";
      action = ":ObsidianSearch";
      options = {
        noremap = true;
        desc = "Search for or create notes in vault";
      };
    }
    {
      key = "<leader>ol";
      action = ":ObsidianLinks<CR>";
      options = {
        noremap = true;
        desc = "Collect all links within current buffer into a picker window";
      };
    }
  ];

  plugins.which-key.settings.spec = [
    {
      __unkeyed = "<leader>o";
      group = "Obsidian";
    }
  ];
}
