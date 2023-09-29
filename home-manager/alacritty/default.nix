{ inputs, lib, config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        # Spread additional padding evenly around the terminal content.
        dynamic_padding = false;

        # Startup Mode (changes require restart)
        startup_mode = "Maximized";
        decorations = "Full";
        opacity = 0.95;
      };
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
      env = {
      	TERM = "xterm-256color";
      };
      font = {
        size = 13;
      };
      cursor = {
        style = "Beam";
        blinking = "Always";
        unfocused_hollow = true;
      };
    } // builtins.fromTOML (builtins.readFile "${inputs.dracula-alacritty-theme}/dracula.toml");
  };
}
