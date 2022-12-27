{ inputs, lib, config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    clock24 = true;
    baseIndex = 1;
    historyLimit = 10000;
    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
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
    extraConfig = ''
      set-option -g default-terminal screen-256color
      set-option -ga terminal-overrides ',xterm-256color:Tc'

      # Mouse works as expected
      set-option -g mouse on

      # window: renumber
      set-option -g renumber-windows on

      # pane: split
      bind | split-window -h -c '#{pane_current_path}'
      bind - split-window -v -c '#{pane_current_path}'
    '';
  };
}
