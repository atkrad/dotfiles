{ inputs, lib, config, pkgs, ... }:

{
  programs.exa = {
    enable = true;
    enableAliases = true;
  };
}
