{
  plugins.treesitter = {
    enable = true;
    nixvimInjections = true;
    nixGrammars = true;
    settings = {
      parser_install_dir = "$XDG_DATA_HOME/nvim/treesitter";
    };
  };
}
