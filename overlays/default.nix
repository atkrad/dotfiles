# This file defines overlays
{ inputs, ... }:
{
  # This one brings my custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    #dracula-theme = prev.dracula-theme.overrideAttrs (oldAttrs: {
    #  version = "4.0.0";
    #  src = final.fetchFromGitHub {
    #    owner = "dracula";
    #    repo = "gtk";
    #    rev = "f9fbda87504e284fe458bd10e9f1f6532b378c4e";
    #    sha256 = "sha256-q3/uBd+jPFhiVAllyhqf486Jxa0mnCDSIqcm/jwGtJA=";
    #  };
    #});
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}

