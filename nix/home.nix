{ config, pkgs, ... }:

{
  home.username = "nozomi";
  home.homeDirectory = "/home/nozomi";

  home.stateVersion = "26.05";

  home.packages = [
    pkgs.git
    pkgs.neovim
    pkgs.tmux
    pkgs.xclip
    pkgs.awscli2
    pkgs.peco
    pkgs.ghq
    pkgs.ripgrep
    pkgs.lazygit
    pkgs.unzip
    pkgs.wget
  ];

  home.file = {};
  home.sessionVariables = {};
  programs.home-manager.enable = true;
}
