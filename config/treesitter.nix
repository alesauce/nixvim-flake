{
  plugins.treesitter = {
    enable = true;
    folding = true;
    nixvimInjections = true;
    nixGrammars = true;
    settings = {
      indent = true;
      parser_install_dir = "$XDG_DATA_HOME/nvim/treesitter";
    };
  };
}
