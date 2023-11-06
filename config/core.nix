{
  config = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    maps = {
      normalVisualOp."<Space>" = {
        action = "<Nop>";
        silent = true;
      };
    };

    options = {
      showmode = false;
      swapfile = false;
      backup = false;
      undofile = true;

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
  };
}
