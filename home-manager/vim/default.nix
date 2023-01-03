{ inputs, lib, config, pkgs, ... }:

{
  programs.vim = {
    enable = true;
    defaultEditor = true;
  };
}
