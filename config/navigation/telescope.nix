{
  plugins.telescope = {
    enable = true;
    settings = {
      defaults = {
        prompt_prefix = " ";
        selection_caret = " ";
        path_display = ["smart"];
        mappings = {
          i = {
            "<C-c>" = "close";
            "<C-n>" = "move_selection_next";
            "<C-e>" = "move_selection_previous";
          };

          n = {
            "<esc>" = "close";
            "n" = "move_selection_next";
            "e" = "move_selection_previous";
          };
        };
        file_ignore_patterns = [
          "^.git/"
          "^.mypy_cache/"
          "^__pycache__/"
          "^output/"
          "^data/"
          "%.ipynb"
        ];
      };
    };
    extensions = {
      fzf-native.enable = true;
      file-browser = {
        enable = true;
        settings = {
          grouped = true;
          depth = 1;
          autoDepth = true;
        };
      };
      media-files = {
        enable = true;
        settings = {
          filetypes = ["png" "webp" "jpg" "jpeg"];
          find_cmd = "rg";
        };
      };
      frecency = {
        enable = true;
        settings = {
          disable_devicons = false;
          show_unindexed = true;
        };
      };
    };
  };
  plugins.which-key.settings.spec = [
    {
      __unkeyed = "<leader>f";
      group = "Telescope Finders";
    }
  ];
  keymaps = [
    # File pickers
    {
      key = "<leader>fb";
      action = ":Telescope file_browser<CR>";
    }
    {
      key = "<leader>ff";
      action = ":Telescope find_files<CR>";
    }
    {
      key = "<leader>fg";
      action = ":Telescope live_grep<CR>";
    }
    {
      key = "<leader>fgi";
      action = ":Telescope git_files<CR>";
    }
    # LSP pickers
    {
      key = "<leader>fr";
      action = ":Telescope lsp_references<CR>";
    }
    {
      key = "<leader>fd";
      action = ":Telescope diagnostics<CR>";
    }
    # Git pickers
    {
      key = "<leader>fc";
      action = ":Telescope git_commits<CR>";
    }
    {
      key = "<leader>fgb";
      action = ":Telescope git_branches<CR>";
    }
    {
      key = "<leader>fs";
      action = ":Telescope git_status<CR>";
    }
  ];
}
