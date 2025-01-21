# Nixie

This repository contains the NixOS configuration and dotfiles for my machines, collectively named **Nixie**. It includes settings for various tools and applications, such as system services, window managers, terminal emulators, and text editors. By sharing these configurations, others can learn from my setup and adapt it to their own needs.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Structure](#structure)
- [Customization](#customization)
- [Acknowledgements](#acknowledgements)

## Overview

The purpose of this repository is to provide a well-organized, version-controlled, and easily maintainable configuration for NixOS. It aims to simplify managing a personal computing environment and ensure consistency across multiple devices. The name **Nixie** reflects the project's modular and elegant approach to NixOS customization.

## Prerequisites

- A NixOS-based system
- Git

## Installation

1. Clone the repository:

```shell
git clone https://github.com/atkrad/nixie.git ~/.nixie
```

2. Apply the NixOS configuration:

```shell
sudo nixos-rebuild switch --flake ~/.nixie#nixie-ci
```

3. Apply the Home Manager configuration:

```shell
home-manager switch --flake ~/.nixie#mohammad@nixie-ci
```

4. Restart your system to ensure all changes take effect:

```shell
systemctl reboot -i
```

## Structure

The repository is organized as follows:

- `nixos/`: Contains system-wide configurations, including the main `configuration.nix`.
- `home-manager/`: Configurations for user-specific settings, like shell aliases, editor preferences, etc.
- `modules/`: Modular configurations for specific services or applications (e.g., Docker, Kubernetes).
- `overlays/`: Custom Nix package definitions or overrides.
- `pkgs/`: Custom Nix packages defined similarly to `nixpkgs`.

This modular structure ensures a clean and maintainable configuration that can be easily extended or reused.

## Customization

To customize the configuration, you can modify the relevant files within the repository. Be sure to test your changes before committing them to ensure they work as expected.

### Example: Adding a New Package

1. Edit the `home-manager` configuration to include the desired package:

```nix
home.packages = with pkgs; [
  vim
  firefox
  # Add your package here
];
```

2. Apply the changes:

```shell
home-manager switch --flake ~/.nixie#mohammad@nixie-ci
```

### Secrets and Sensitive Data

Avoid committing sensitive information (e.g., API keys, passwords). Instead, use tools like `git-crypt` or environment variables to manage secrets securely.

## Acknowledgements

This repository is inspired by the work and ideas of numerous NixOS community members. Special thanks to the maintainers of NixOS, Home Manager, and related projects for their invaluable contributions.

Feel free to use, adapt, and share this configuration as needed, but please give credit where it's due.

---

If you have any questions or suggestions, feel free to open an issue or submit a pull request. Contributions and feedback are always welcome!

