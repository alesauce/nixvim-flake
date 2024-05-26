{pkgs, ...}: {
  # TODO: configure terminal emulator: https://neovim.io/doc/user/nvim_terminal_emulator.html#terminal-emulator
  config = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = [
      {
        key = "<Space>";
        action = "<Nop>";
        options = {
          silent = true;
          desc = "Mapping space to Nop for global leader use";
        };
      }
    ];

    opts = {
      showmode = false;
      swapfile = false;
      backup = false;
      undofile = true;
      termguicolors = true;
      # Cursor and line formatting
      cursorline = true;
      cursorlineopt = "number";
      number = true;
      relativenumber = true;
      wrap = true;
      linebreak = true;
      # Line indentation
      list = true;
      tabstop = 4;
      expandtab = true;
      shiftwidth = 4;
      smartindent = true;
    };

    autoCmd = [
      {
        event = "FileType";
        pattern = "nix";
        command = "setlocal tabstop=2 shiftwidth=2 softtabstop=2";
      }
    ];

    extraConfigLua = ''
      vim.opt.listchars:append "eol:↴"
    '';

    viAlias = true;
    vimAlias = true;
  };
}
