{
  description = "Home Manager configuration of nozomi";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      # systemを渡すと、その環境用のhome-manager設定を作るヘルパー
      mkHome =
        system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
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
