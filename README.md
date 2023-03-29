# Atkrad's NixOS Configuration and Dotfiles

This repository contains the NixOS configuration and dotfiles for my machines. It includes settings for various tools and applications, such as system services, window managers, terminal emulators, and text editors. By sharing these configurations, others can learn from my setup and adapt it to their own needs.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Structure](#structure)
- [Customization](#customization)
- [Acknowledgements](#acknowledgements)

## Overview

The purpose of this repository is to provide a well-organized, version-controlled, and easily maintainable configuration for NixOS. It aims to make it easier for users to manage their personal computing environment and ensure consistency across multiple devices.

## Prerequisites

- A NixOS-based system
- Git

## Installation

1. Clone the repository:

```shell
git clone https://github.com/atkrad/dotfiles.git ~/.dotfiles
```

2. Apply the NixOS configuration:

```shell
sudo nixos-rebuild switch --flake ~/dotfiles#nixie-ci
```

3. Apply the Home Manager configuration:

```shell
home-manager switch --flake ~/dotfiles#mohammad@nixie-ci
```

4. Restart your system to ensure all changes take effect:

```shell
systemctl reboot -i
```

## Structure

The repository is organized as follows:

- `nixos/`: Contains the main `configuration.nix` file and other NixOS-specific configurations.
- `home-manager/`: Contains configuration files for Home Manager, which manages user-specific dotfiles and settings.
- `modules/`: Contains NixOS modules for configuring specific applications or services.
- `overlays/`: Contains Nix package overlays to customize or extend the default NixOS package set.
- `pkgs/`: Contains custom packages, that can be defined similarly to ones from nixpkgs.

## Customization

To customize the configuration, you can modify the relevant files within the repository. Be sure to test your changes before committing them to ensure they work as expected.

If you want to add a new package, service, or configuration, consider creating a new NixOS module within the `modules/` directory to keep the configuration modular and maintainable.

## Acknowledgements

This repository is inspired by the work and ideas of numerous NixOS community members. Feel free to use, adapt, and share this configuration as needed, but please give credit where it's due.

---

If you have any questions or suggestions, feel free to open an issue or submit a pull request. Contributions and feedback are always welcome!

