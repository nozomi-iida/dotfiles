{ config, pkgs, ... }:

{
  home.username = "nozomi";
  home.homeDirectory = "/home/nozomi";

  home.stateVersion = "26.05";

  home.packages = [];

  home.file = {};
  home.sessionVariables = {};
  programs.home-manager.enable = true;
}
