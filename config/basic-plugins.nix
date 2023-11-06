{ pkgs }:
{
  # Using this file to store all the "one-liner" plugins that don't require a bunch of additional
  # config options
  plugins = {
    nix.enable = true;
    tmux-navigator.enable = true;
    indent-blankline = {
      enable = true;
      showEndOfLine = true;
    };
    lightline = {
      enable = true;
      colorscheme = "selenized_black";
    };
    nvim-autopairs = {
      enable = true;
      checkTs = true;
      tsConfig = {
        lua = ["string" "source"];
      };
    };
    todo-comments.enable = true;

    # TODO: configure undotree: https://github.com/mbbill/undotree
    # nixvim docs: https://nix-community.github.io/nixvim/#_plugins_undotree_enable
    undotree.enable = true;

    # TODO: configure which-key: https://github.com/folke/which-key.nvim
    # nixvim docs: https://nix-community.github.io/nixvim/#_plugins_which_key_enable
    which-key.enable = true;

    # TODO: configure toggleterm: https://github.com/akinsho/toggleterm.nvim
    # nixvim docs: https://nix-community.github.io/nixvim/#_plugins_toggleterm_enable
    toggleterm.enable = true;

    extraPlugins = with pkgs.vimPlugins; [
      guess-indent-nvim
    ];

    extraConfigLua = ''
      require('guess-indent').setup {}
    '';
  };
}
