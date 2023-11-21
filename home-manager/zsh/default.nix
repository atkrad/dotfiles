{ inputs, lib, config, pkgs, ... }:

{
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
    plugins = with pkgs; [
      {
        name = "fzf-tab";
        src = zsh-fzf-tab.src;
      }
    ];
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
}
