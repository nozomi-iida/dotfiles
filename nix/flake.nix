{
  description = "Home Manager configuration of nozomi";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # tmuxのプラグインマネージャーtpm本体。flake = falseでソースをそのまま取得し
    # home.nixでsymlink配置する。バージョンはflake.lockで固定される
    tpm = {
      url = "github:tmux-plugins/tpm";
      flake = false;
    };
    # herdr本体をflakeから取得する
    herdr = {
      url = "github:ogulcancelik/herdr";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, tpm, herdr, ... }:
    let
      # systemを渡すと、その環境用のhome-manager設定を作るヘルパー
      mkHome =
        system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [ ./home.nix ];
          # home.nixへ渡す: tpmのソース(symlink配置用)とherdr flake(home.packages用)
          extraSpecialArgs = { inherit tpm herdr; };
        };
    in
    {
      homeConfigurations = {
        wsl = mkHome "x86_64-linux"; # WSL / Linux
        mac = mkHome "aarch64-darwin"; # Mac (Apple Silicon)
      };
    };
}
