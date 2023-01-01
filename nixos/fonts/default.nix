{ inputs, outputs, lib, config, pkgs, ... }:

{
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      inconsolata
      jetbrains-mono
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      nerdfonts
      # Persian Fonts
      vazir-fonts
      vazir-code-font
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Vazirmatn" "Noto Sans" ];
        sansSerif = [ "Vazirmatn" "Noto Serif" ];
        monospace = [ "Jetbrains Mono" "Inconsolata" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
