{ config, pkgs, lib, tpm, herdr, ... }:

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
    pkgs.gh
    # tmux-claude-session-managerのセッションピッカーUIに必要
    pkgs.fzf
    # herdr(https://herdr.dev/)をflakeから導入する
    herdr.packages.${pkgs.stdenv.hostPlatform.system}.default
  ]
  # Linux(X11)専用。Macはpbcopy内蔵なので不要
  ++ lib.optionals pkgs.stdenv.isLinux [
    pkgs.xclip
  ];

  # tpm本体をsymlinkで配置する。プラグインは従来どおり prefix + I で導入
  home.file.".config/tmux/plugins/tpm".source = tpm;

  home.sessionVariables = {};

  # 言語ランタイム管理のmise本体をhome-managerで管理する
  # zsh有効化(activate)は自前の.zshrcで行う(home-managerがzshを管理していないため
  # enableZshIntegrationは効かない)
  programs.mise.enable = true;

  # グローバル設定 ~/.config/mise/config.toml をhome-managerで生成する
  # 標準パスに置かれるため自動で信頼され、どのディレクトリでもツールが使える
  programs.mise.globalConfig = {
    tools = {
      neovim = "latest";
      node = "22";
      pnpm = "9";
      go = "latest";
      rust = "latest";
      deno = "latest";
      java = "latest";
      bun = "latest";
    };
  };

  programs.home-manager.enable = true;
}
