{ inputs, outputs, lib, config, pkgs, ... }:

{
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # I split up my configuration and imported pieces of it here:
    ./zsh
    ./bash
    ./neovim
    ./tmux
    ./fzf
    ./starship
    ./bat
    ./git
    ./alacritty
    ./gnome
    ./most
    ./go
    ./exa
    ./gpg
    ./keybase
    ./zoxide
    ./vscode
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays your own flake exports (from overlays dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # Or overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];

    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "mohammad";
    homeDirectory = "/home/mohammad";
  };

  home.packages = with pkgs; [
    file
    gnumake
    dig
    btop
    curl
    firefox
    google-chrome
    teams
    spotify
    vlc
    appimage-run
    
    # Development
    gcc
    nodejs
    unstable.jetbrains.goland
    unstable.jetbrains.phpstorm
    unstable.jetbrains.datagrip
    unstable.postman
    jq
    grpcurl
    hugo
    rnix-lsp
    unstable.open-policy-agent

    # K8S toolset
    kubectx
    kubectl
    kubernetes-helm
    minikube
    kind
    lens
    argo

    buildah
    
    # Infra
    awscli2
    terraform
    ansible
    bitwarden-cli
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
