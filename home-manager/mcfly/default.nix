{ inputs, lib, config, pkgs, ... }:

{
  programs.mcfly = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableLightTheme = false;
    fuzzySearchFactor = 2;
    keyScheme = "vim";
  };

  home.sessionVariables = {
    MCFLY_RESULTS = 20;
  };
}
