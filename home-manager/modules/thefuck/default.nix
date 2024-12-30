{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.thefuck = {
    enable = true;
  };
}
