{ inputs, lib, config, pkgs, ... }:

{
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
