{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    #gnomeExtensions.persian-calendar
    gnomeExtensions.tiling-assistant
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
    gnome-tweaks
    gnome-boxes
    ptyxis
    gradience
  ];

  gtk = {
    enable = true;
    #theme = {
    #  name = "Dracula";
    #  package = pkgs.dracula-theme;
    #};
    cursorTheme = {
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
    };
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/input-sources" = {
        sources = [(lib.hm.gvariant.mkTuple ["xkb" "us"]) (lib.hm.gvariant.mkTuple ["xkb" "ir"])];
        per-window = false;
      };
      "org/gnome/Console" = {
        #font-scale = 1.3;
        theme = "auto";
      };
      "org/gnome/desktop/calendar" = {
        show-weekdate = false;
      };
      "org/gnome/desktop/interface" = {
        gtk-theme = "Adwaita"; # e.g. "Adwaita", "Dracula"
        show-battery-percentage = true;
        color-scheme = "prefer-dark";
        monospace-font-name = "JetbrainsMono Nerd Font 13";
        locate-pointer = true;
      };
      "org/gnome/desktop/wm/preferences" = {
        theme = ""; # e.g. "", "Dracula"
        workspace-names = [
          "main"
          "dev"
        ];
        button-layout = "appmenu:minimize,close";
      };
      "org/gnome/shell/extensions/user-theme" = {
        name = ""; # e.g. "", "Dracula"
      };
      "org/gnome/desktop/peripherals/mouse" = {
        natural-scroll = false;
      };
      "org/gnome/desktop/peripherals/touchpad" = {
        natural-scroll = false;
        tap-to-click = true;
      };
      "org/gnome/desktop/background" = {
        picture-uri = "file://${inputs.dracula-wallpaper}/first-collection/base.png";
        picture-uri-dark = "file://${inputs.dracula-wallpaper}/first-collection/base.png";
      };
      "org/gnome/desktop/screensaver" = {
        picture-uri = "file://${inputs.dracula-wallpaper}/first-collection/base.png";
      };
      "org/gnome/shell/app-switcher" = {
        current-workspace-only = true;
      };
      "org/gnome/shell/extensions/auto-move-windows" = {
        application-list = [
          "firefox.desktop:1"
          "goland.desktop:2"
          "phpstorm.desktop:2"
          "datagrip.desktop:2"
          "postman.desktop:2"
          "teams-for-linux.desktop:3"
          "spotify.desktop:4"
        ];
      };
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          #"PersianCalendar@oxygenws.com"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "tiling-assistant@leleat-on-github"
          "dash-to-dock@micxgx.gmail.com"
          "GPaste@gnome-shell-extensions.gnome.org"
          "appindicatorsupport@rgcjonas.gmail.com"
          "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        ];
        favorite-apps = [
          "firefox.desktop"
          "org.gnome.Ptyxis.desktop"
          "org.gnome.Nautilus.desktop"
          "postman.desktop"
          "goland.desktop"
          "phpstorm.desktop"
          "datagrip.desktop"
        ];
      };
    };
  };
  #home.file.".config/gtk-4.0/gtk.css".source = "${pkgs.dracula-theme}/share/themes/Dracula/gtk-4.0/gtk.css";
  #home.file.".config/gtk-4.0/gtk-dark.css".source = "${pkgs.dracula-theme}/share/themes/Dracula/gtk-4.0/gtk-dark.css";
  #home.file.".config/gtk-4.0/assets".source = "${pkgs.dracula-theme}/share/themes/Dracula/gtk-4.0/assets";
  #home.file.".config/assets".source = "${pkgs.dracula-theme}/share/themes/Dracula/assets";
}
