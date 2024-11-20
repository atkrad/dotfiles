{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # I split up my configuration and imported pieces of it here:
    ./modules/nixpkgs
    ./modules/zsh
    ./modules/bash
    ./modules/neovim
    ./modules/tmux
    ./modules/fzf
    ./modules/starship
    ./modules/bat
    ./modules/btop
    ./modules/git
    ./modules/alacritty
    ./modules/gnome
    ./modules/most
    ./modules/go
    ./modules/eza
    ./modules/gpg
    ./modules/keybase
    ./modules/zoxide
    ./modules/vscode
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "mohammad";
    homeDirectory = "/home/mohammad";
  };

  home.packages = with pkgs; [
    file
    tree
    gnumake
    dig
    curl
    firefox
    google-chrome
    unstable.teams-for-linux
    unstable.spotify
    vlc
    openssl
    appimage-run
    unstable.thunderbird

    # Development
    gcc
    unstable.jetbrains.goland
    unstable.jetbrains.phpstorm
    unstable.jetbrains.datagrip
    unstable.jetbrains-toolbox
    #postman
    jq
    grpcurl
    unstable.wait4x
    unstable.ulid

    # K8S toolset
    kubectx
    kubectl
    unstable.kubernetes-helm
    minikube
    kind
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
