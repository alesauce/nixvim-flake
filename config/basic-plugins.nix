{pkgs, ...}: {
  # Using this file to store all the "one-liner" plugins that don't require a bunch of additional
  # config options
  plugins = {
    nix.enable = true;
    tmux-navigator.enable = true;
    todo-comments.enable = true;
    # TODO: configure which-key: https://github.com/folke/which-key.nvim
    # nixvim docs: https://nix-community.github.io/nixvim/#_plugins_which_key_enable
    which-key.enable = true;
  };

  extraPlugins = with pkgs.vimPlugins; [
    guess-indent-nvim
  ];

  extraConfigLua = ''
    require('guess-indent').setup {}
  '';
}
