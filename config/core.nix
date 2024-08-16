{
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

    luaLoader.enable = true;

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
      smartindent = false;
      # Folding
      # https://www.reddit.com/r/neovim/comments/1behv16/comment/kutge8o/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
      foldmethod = "expr";
      foldexpr = "v:lua.vim.treesitter.foldexpr()";
      foldtext = "";
      foldlevelstart = 99;
    };

    extraConfigLua = ''
      vim.opt.fillchars:append "fold: "
      vim.opt.listchars:append "eol:↴"
    '';

    viAlias = true;
    vimAlias = true;
  };
}
