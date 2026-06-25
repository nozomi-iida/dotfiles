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
  };

  outputs =
    { nixpkgs, home-manager, tpm, ... }:
    let
      # systemを渡すと、その環境用のhome-manager設定を作るヘルパー
      mkHome =
        system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          # tpmのソースをhome.nixへ渡す
          extraSpecialArgs = { inherit tpm; };
          modules = [ ./home.nix ];
        };
    in
    {
      homeConfigurations = {
        wsl = mkHome "x86_64-linux"; # WSL / Linux
        mac = mkHome "aarch64-darwin"; # Mac (Apple Silicon)
      };
    };
}
