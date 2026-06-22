{ config, pkgs, lib, ... }:

{
  home.username = "nozomi";
  home.homeDirectory =
    if pkgs.stdenv.isDarwin then "/Users/nozomi" else "/home/nozomi";

  home.stateVersion = "26.05";

  home.packages = [
    pkgs.git
    pkgs.neovim
    pkgs.tmux
    pkgs.awscli2
    pkgs.peco
    pkgs.ghq
    pkgs.ripgrep
    pkgs.lazygit
    pkgs.unzip
    pkgs.wget
    # tmux-claude-session-managerのセッションピッカーUIに必要
    pkgs.fzf
  ]
  # Linux(X11)専用。Macはpbcopy内蔵なので不要
  ++ lib.optionals pkgs.stdenv.isLinux [
    pkgs.xclip
  ];

  home.file = {};

  home.sessionVariables = {};
  programs.home-manager.enable = true;
}
