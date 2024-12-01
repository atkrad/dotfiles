{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
      vazir-fonts
    ];

    fontconfig = {
      defaultFonts = {
        serif = ["Vazirmatn" "Noto Sans"];
        sansSerif = ["Vazirmatn" "Noto Serif"];
        # The Alacritty can't use the emoji category, so I append the emoji fonts as the "monospace" fallback
        monospace = ["JetbrainsMono Nerd Font" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji" "Noto Emoji"];
      };
    };
  };
}
