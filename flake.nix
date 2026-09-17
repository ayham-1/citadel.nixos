{
  description = "The Citadel NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    nvf.url = "github:notashelf/nvf";
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nur,
    flake-utils,
    home-manager,
    nixos-hardware,
    stylix,
    sops-nix,
    impermanence,
    nvf,
    niri,
    disko,
    ...
  } @ attrs: let
    system = "x86_64-linux";
    ide = nvf.lib.neovimConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [./services/nvf.nix];
    };
    userLib = import ./lib/users.nix {
      inherit home-manager niri;
    };
    commonModules = [
      stylix.nixosModules.stylix
      nur.modules.nixos.default
      nvf.nixosModules.default
      disko.nixosModules.disko
      home-manager.nixosModules.home-manager
    ];
  in {
    packages.${system}.ide = ide.neovim;

    nixosConfigurations = {
      alpha = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = attrs;
        modules =
          commonModules
          ++ [
            ./machines/alpha/configuration.nix
          ]
          ++ userLib.mkUsers ["ayham"];
      };

      veta = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = attrs;
        modules =
          commonModules
          ++ [
            ./machines/veta/configuration.nix
          ]
          ++ userLib.mkUsers ["ayham"];
      };

      labor = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = attrs;
        modules =
          commonModules
          ++ [
            ./machines/labor/configuration.nix
          ]
          ++ userLib.mkUsers ["ayham"];
      };
    };
  };
}
