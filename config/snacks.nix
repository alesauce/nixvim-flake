{
  plugins = {
    snacks = {
      enable = true;
      settings = {
        indent.enabled = true;
        quickfile.enabled = true;
        scope.enabled = true;
        scroll.enabled = true;
        # TODO: configure scratch plugin for quick notes/slipbox https://github.com/folke/snacks.nvim/blob/main/docs/scratch.md
        terminal = {
          enabled = true;
        };
      };
    };
    which-key.settings.spec = [
      {
        mode = "n";
        __unkeyed-1 = "<leader>t";
        icon = "🍿";
        group = "Snacks Terminal";
      }
    ];
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>tt";
      action = "<cmd>lua Snacks.terminal.toggle()<cr>";
      options = {
        desc = "Toggle terminal";
      };
    }
    {
      mode = "n";
      key = "<leader>tg";
      action = "<cmd>lua Snacks.terminal.get()<cr>";
      options = {
        desc = "Get/create terminal";
      };
    }
    {
      mode = "n";
      key = "<leader>to";
      action = "<cmd>lua Snacks.terminal.open()<cr>";
      options = {
        desc = "Open terminal";
      };
    }
    {
      mode = "n";
      key = "<leader>to";
      action = "<cmd>lua Snacks.terminal.list()<cr>";
      options = {
        desc = "List terminals";
      };
    }
  ];
}
