{
  description = "The Citadel NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nur.url = "github:nix-community/NUR";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nur, flake-utils, home-manager
    , nixos-hardware, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      unstablePkgs = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      commonModules = [
        nur.modules.nixos.default
        ({ pkgs, ... }: {
          nixpkgs.overlays = [ (final: prev: { unstable = unstablePkgs; }) ];
        })
      ];
    in {
      nixosConfigurations = {
        alpha = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = commonModules ++ [
            ./machines/alpha/configuration.nix
            ./users/ayham/base.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ];
        };

        veta = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = commonModules ++ [
            ./machines/veta/configuration.nix
            ./users/ayham/base.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ];
        };

        gamma = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = commonModules ++ [
            ./machines/gamma/configuration.nix
            ./users/ayham/base.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ];
        };

      };
    };
}
