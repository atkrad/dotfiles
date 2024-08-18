# This file defines overlays
{inputs, ...}: {
  # This one brings my custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    dracula-theme = prev.dracula-theme.overrideAttrs (oldAttrs: {
      version = "4.0.0";
      src = final.fetchFromGitHub {
        owner = "dracula";
        repo = "gtk";
        rev = "48bdcc5e37c90d74e7e2139412a89209cc05a672";
        sha256 = "sha256-OK5jCAC4puW2HQnvB56UcCcKHciX7n4nf+FHM1pbPPk=";
      };
    });
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
