{
  description = "The Citadel NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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
    ...
  } @ attrs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      #config.allowUnfree = true;
    };
    commonModules = [
      stylix.nixosModules.stylix
      nur.modules.nixos.default
      nvf.nixosModules.default
    ];
  in {
    # neovim
    packages."x86_64-linux".default =
      (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [./users/ayham/progs/nvf.nix];
      }).neovim;

    nixosConfigurations = {
      alpha = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = attrs;
        modules =
          commonModules
          ++ [
            ./machines/alpha/configuration.nix
            ./users/ayham/base.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = null;
              home-manager.extraSpecialArgs = {inherit attrs;};

              home-manager.sharedModules = [
                niri.homeModules.niri
              ];

              home-manager.users.ayham = import ./users/ayham/home.nix;
            }
          ];
      };

      veta = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = attrs;
        modules =
          commonModules
          ++ [
            ./machines/veta/configuration.nix
            ./users/ayham/base.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = null;

              home-manager.sharedModules = [
                niri.homeModules.niri
              ];

              home-manager.users.ayham = import ./users/ayham/home.nix;
            }
          ];
      };

      # tbd: whenever gamma is meant to be remade
      #gamma = nixpkgs.lib.nixosSystem {
      #  inherit system;
      #  specialArgs = attrs;
      #  modules =
      #    commonModules
      #    ++ [
      #      ./machines/gamma/configuration.nix
      #      ./users/ayham/base.nix
      #      home-manager.nixosModules.home-manager
      #      {
      #        home-manager.useGlobalPkgs = true;
      #        home-manager.useUserPackages = true;
      #        home-manager.backupFileExtension = null;

      #        home-manager.sharedModules = [
      #          niri.homeModuels.niri
      #        ];

      #        home-manager.users.ayham = import ./users/ayham/home.nix;
      #      }
      #    ];
      #};

      labor = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = attrs;
        modules =
          commonModules
          ++ [
            ./machines/labor/configuration.nix
            ./users/ayham/base.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = null;

              home-manager.sharedModules = [
                niri.homeModuels.niri
              ];

              home-manager.users.ayham = import ./users/ayham/home.nix;
            }
          ];
      };
    };
  };
}
