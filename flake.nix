{
  description = "My NixOS configurations";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # I use the unstable nixpkgs repo for some packages.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    # Delta is a syntax-highlighting pager for git, diff, and grep output.
    # NOTE: Include just for "themes.gitconfig" file
    delta = {
      url = github:dandavison/delta;
      flake = false;
    };

    dracula-wallpaper = {
      url = "github:dracula/wallpaper";
      flake = false;
    };

    dracula-alacritty-theme = {
      url = "github:dracula/alacritty";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in rec {
    # My custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};

    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;

    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild switch --flake .#nixie-ci'
    nixosConfigurations = {
      nixie-ci = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;}; # Pass flake inputs and outputs to the config
        modules = [
          # My main nixos configuration file
          ./nixos/configuration.nix
	  inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager switch --flake .#mohammad@nixie-ci'
    homeConfigurations = {
      "mohammad@nixie-ci" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home Manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          # My main home-manager configuration file
          ./home-manager/home.nix
        ];
      };
    };
  };
}
