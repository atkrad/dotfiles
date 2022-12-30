{ inputs, lib, config, pkgs, ... }:

{
  programs.go = {
    enable = true;
    goPath = "go"; # Primary GOPATH relative to HOME.
    goPrivate = [
      "gitlab.ci.fdmg.org"
    ];
  };
}
