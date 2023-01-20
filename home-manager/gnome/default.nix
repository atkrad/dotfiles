{ inputs, lib, config, pkgs, ... }:

{
  home.packages = with pkgs; [
    #gnomeExtensions.persian-calendar
    gnomeExtensions.appindicator
    gnome.gnome-tweaks
    dracula-theme
  ];

  gtk = {
    enable = true;
    #theme = {
    #  name = "Dracula";
    #  package = pkgs.dracula-theme;
    #};
    cursorTheme.name = "Dracula-cursors";
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
        color-scheme = "prefer-dark";
      };
      #"org/gnome/desktop/wm/preferences" = {
      #  theme = "Dracula";
      #};
      #"org/gnome/shell/extensions/user-theme" = {
      #  name = "Dracula";
      #};
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
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "GPaste@gnome-shell-extensions.gnome.org"
          "appindicatorsupport@rgcjonas.gmail.com"
        ];
        favorite-apps = [
          "firefox.desktop"
          "Alacritty.desktop"
          "org.gnome.Nautilus.desktop"
          "postman.desktop"
          "goland.desktop"
          "phpstorm.desktop"
          "datagrip.desktop"
        ];
      };
    };
  };
}
