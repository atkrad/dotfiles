{
  description = "My NixOS configurations";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";

    # I use the unstable nixpkgs repo for some packages.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Pure Nix flake utility functions
    flake-utils.url = "github:numtide/flake-utils";

    # Nix-LD, Run unpatched dynamic binaries on NixOS.
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "flake-utils";
      };
    };
    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "flake-utils";
      };
    };

    # Delta is a syntax-highlighting pager for git, diff, and grep output.
    # NOTE: Include just for "themes.gitconfig" file 
    delta = { 
      url = github:dandavison/delta; 
      flake = false; 
    };

    dracula-gtk-theme = {
      url = "github:dracula/gtk";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
    in
    rec {
      # Your custom packages
      # Acessible through 'nix build', 'nix shell', etc
      packages = inputs.flake-utils.lib.eachDefaultSystem (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./pkgs { inherit pkgs; }
      );

      # Devshell for bootstrapping
      # Acessible through 'nix develop' or 'nix-shell' (legacy)
      devShells = inputs.flake-utils.lib.eachDefaultSystem (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; }
      );

      # My custom packages and modifications, exported as overlays
      overlays = import ./overlays;

      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;

      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild switch --flake .#nixie-ci'
      nixosConfigurations = {
        nixie-ci = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; }; # Pass flake inputs and outputs to the config
          modules = [
            # My main nixos configuration file
            ./nixos/configuration.nix
          ];
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager switch --flake .#mohammad@nixie-ci'
      homeConfigurations = {
        "mohammad@nixie-ci" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux"; # Home Manager requires 'pkgs' instance
          extraSpecialArgs = { inherit inputs outputs; }; # Pass flake inputs to our config
          modules = [
            # My main home-manager configuration file
            ./home-manager/home.nix
          ];
        };
      };
    };
}
