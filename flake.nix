{
  description = "My Nix configurations";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    # Nix-LD, Run unpatched dynamic binaries on NixOS.
    nix-ld.url = "github:Mic92/nix-ld";
    nix-alien.url = "github:thiagokokada/nix-alien";
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alacritty-theme = { 
      url = github:eendroroy/alacritty-theme; 
      flake = false; 
    }; 
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild switch --flake .#nixie-ci'
    nixosConfigurations = {
      nixie-ci = nixpkgs.lib.nixosSystem {
        #inherit system;
        specialArgs = { inherit inputs; }; # Pass flake inputs to the config
        modules = [ 
          ./configuration.nix
          ({ inputs, pkgs, ... }: {
            nixpkgs.overlays = [
              inputs.nix-alien.overlays.default
            ];
            imports = [
              inputs.nix-ld.nixosModules.nix-ld
            ];
            environment.systemPackages = with pkgs; [
              nix-alien
              nix-index # not necessary, but recommended
              nix-index-update
            ];
          })
        ];
      };
    };
    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager switch --flake .#mohammad@nixie-ci'
    homeConfigurations = {
      "mohammad@nixie-ci" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home Manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
        modules = [ 
          ./home.nix
        ];
      };
    };
  };
}
