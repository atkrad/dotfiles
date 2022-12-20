{ inputs, lib, config, pkgs, ... }:

{
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
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

  services.keybase.enable = true;

  home.packages = with pkgs; [
    file
    most
    htop
    btop
    curl
    vim
    firefox
    teams
    #gnomeExtensions.persian-calendar    
    gnomeExtensions.appindicator

    # Development
    gcc
    jetbrains.goland
    jetbrains.phpstorm
    jetbrains.datagrip
    postman
    ghq
    
    # K8S toolset
    kubectx
    kubectl
    kubernetes-helm

    awscli2
    ansible
    jq
    bitwarden-cli
  ];

  home.sessionVariables = {
    MANPAGER = "most";
    MCFLY_RESULTS = 20;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash.enable = true;
  programs.zsh = {
    enable = true;
    enableVteIntegration = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    history = {
      extended = true;
      ignorePatterns = [
        "rm *"
        "pkill *"
        "reboot"
        "shutdown"
        "shutdown *"
      ];
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "cp"
        "git"
        "sudo"
        "history-substring-search"
        "helm"
        "docker"
        "aws"
        "ansible"
        "golang"
      ];
    };
  };

  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    shortcut = "a";
    clock24 = true;
    baseIndex = 1;
    historyLimit = 10000;
    plugins = with pkgs.tmuxPlugins; [
      {
	plugin = dracula;
	extraConfig = ''
          set -g @dracula-show-left-icon session
          set -g @dracula-show-flags true
	  set -g @dracula-show-powerline true
	  set -g @dracula-refresh-rate 2
	  set -g @dracula-military-time true
          set -g @dracula-plugins "time"
	'';
      }
    ];
  };

  programs.go = {
    enable = true;
    goPath = "go"; # Primary GOPATH relative to HOME.
    goPrivate = [
      "gitlab.ci.fdmg.org"
    ];
  };

  programs.alacritty = {
    enable = true;
    settings = {
      shell = {
        program = "tmux";
        args = [
          "new-session"
          "-A"
          "-D"
          "-s"
          "main"
        ];
      };
      font = {
        size = 15;
        normal = {
          family = "monospace";
          style = "Regular";
        };
        bold = {
          family = "monospace";
          style = "Bold";
        };
        italic = {
          family = "monospace";
          style = "Italic";
        };
      };
      # Colors (Dracula)
      # themes: https://github.com/eendroroy/alacritty-theme
      colors = {
        # Default colors
        primary = {
          background = "0x282a36";
          foreground = "0xf8f8f2";
        };
        # Normal colors
        normal = {
          black = "0x000000";
          red = "0xff5555";
          green = "0x50fa7b";
          yellow = "0xf1fa8c";
          blue = "0xbd93f9";
          magenta = "0xff79c6";
          cyan = "0x8be9fd";
          white = "0xbbbbbb";
        };
        # Bright colors
        bright = {
          black = "0x555555";
          red = "0xff5555";
          green = "0x50fa7b";
          yellow = "0xf1fa8c";
          blue = "0xcaa9fa";
          magenta = "0xff79c6";
          cyan = "0x8be9fd";
          white = "0xffffff";
        };
      };
    };
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Dracula";
    };
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.mcfly = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableLightTheme = false;
    fuzzySearchFactor = 2;
    keyScheme = "vim";
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "Mohammad Abdolirad";
    userEmail = "m.abdolirad@gmail.com";
    signing = {
      signByDefault = true;
      key = "62CAFDB8";
    };
    delta = {
      enable = true;
      options = {
        features = "decorations calochortus-lyallii";
        syntax-theme = "Dracula";
        line-numbers = true;
        navigate = true;
        side-by-side = true;
      };
    };
    extraConfig = {
      format.signoff = true;
      diff.colorMoved = "default";
      ghq = {
        vcs = "git";
        root = "~/Workspace";
      };
      merge.conflictstyle = "diff3";
      pager = {
        diff = "delta";
        log = "delta";
        reflog = "delta";
        show = "delta";
        blame = "delta";
      };
      url = {
        "git@gitlab.ci.fdmg.org:".insteadOf = "https://gitlab.ci.fdmg.org/";
      };
    };
    includes = [
      {
        path = "${inputs.delta}/themes.gitconfig";
      }
      {
        condition = "gitdir:~/Workspace/gitlab.ci.fdmg.org/";
	contents = {
          user = {
            name = "Mohammad Abdolirad";
            email = "mohammad.abdolirad@company.info";
            signingKey = "62CAFDB8";
	  };
        };
      }
    ];
  };

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableSshSupport = true;
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/input-sources" = {
        sources = [(lib.hm.gvariant.mkTuple ["xkb" "us"]) (lib.hm.gvariant.mkTuple ["xkb" "ir"])];
        per-window = false;
      };
      "org/gnome/Console" = {
        font-scale = 1.3;
        theme = "auto";
      };
      "org/gnome/desktop/calendar" = {
        show-weekdate = true;
      };
      "org/gnome/desktop/interface" = {
        show-battery-percentage = true;
      };
      "org/gnome/desktop/peripherals/mouse" = {
        natural-scroll = false;
      };
      "org/gnome/desktop/peripherals/touchpad" = {
        natural-scroll = false;
        tap-to-click = true;
      };
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          #"PersianCalendar@oxygenws.com"
          "GPaste@gnome-shell-extensions.gnome.org"
          "appindicatorsupport@rgcjonas.gmail.com"
        ];
      };
    };
  };

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
