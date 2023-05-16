{ inputs, outputs, lib, config, pkgs, ... }:

{
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      inconsolata
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      vazir-fonts
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Vazirmatn" "Noto Sans" ];
        sansSerif = [ "Vazirmatn" "Noto Serif" ];
	# The Alacritty can't use the emoji category, so I append the emoji fonts as the "monospace" fallback
        monospace = [ "Jetbrains Mono Nerd Font" "ٰInconsolata" "Noto Color Emoji" ];
        emoji = [ "Noto Color Emoji" "Noto Emoji" ];
      };
    };
  };
}
