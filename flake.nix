{
  description = "`home-manager` configuration for `mbana` targeting multiple architectures";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      # url = "github:nix-community/home-manager/release-26.05";
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nix-index-database,
      ...
    }:
    let
      systems = [
        "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin"
      ];
      forAllSystems =
        f:
        builtins.listToAttrs (
          map (system: {
            name = system;
            value = f system;
          }) systems
        );
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          pkgsUnstable = nixpkgs-unstable.legacyPackages.${system};
        in
        {
          homeConfigurations.mbana = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = {
              inherit pkgsUnstable;
              inherit inputs;
            };
            modules = [
              ./home.nix
              nix-index-database.homeModules.default
              # optional to also wrap and install comma
              { programs.nix-index-database.comma.enable = true; }
            ];
          };
        }
      );
    };
}
