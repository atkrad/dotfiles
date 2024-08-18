{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      dracula-nvim
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = builtins.readFile ./treesitter.lua;
      }
    ];
    extraConfig = ''
      syntax on
      syntax enable
      set number                        " Show line numbers
      set ruler                         " Show line and column number
      colorscheme dracula
    '';
    extraPackages = with pkgs; [
      # For tree-sitter
      gcc
      lua
    ];
  };
}
