{
  inputs,
  pkgs,
  ...
}: {
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    zlib
    libgcc
    libstdcxx5
    stdenv.cc.cc
  ];

  nixpkgs.overlays = [
    inputs.nix-alien.overlays.default
  ];
  environment.systemPackages = with pkgs; [
    nix-alien
    nix-index # not necessary, but recommended
    nix-index-update
  ];
}
