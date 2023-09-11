{
  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-flake.url = "github:srid/nixos-flake";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nixd.url = "github:nix-community/nixd";
    nuenv.url = "github:DeterminateSystems/nuenv";

    dotzsh.url = "github:number5/dotzsh";
    dotzsh.flake = false;
  };

  outputs = inputs @ {self, ...}:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      imports = [
        inputs.nixos-flake.flakeModule
        ./nixos
      ];

      flake = let
        myUserName = "bruce";
      in {
        # Configurations for Linux (NixOS) machines
        nixosConfigurations = {
          chestnut = self.nixos-flake.lib.mkLinuxSystem {
            nixpkgs.hostPlatform = "x86_64-linux";
            imports = [
              self.nixosModules.common # See below for "nixosModules"!
              # Your machine's configuration.nix goes here
              ./systems/chestnut/default.nix

              # Your home-manager configuration
              self.nixosModules.home-manager
              {
                home-manager.users.${myUserName} = {
                  imports = [
                    self.homeModules.common # See below for "homeModules"!
                    self.homeModules.linux
                    ./home/common.nix
                    ./home/home-manager-options.nix
                    ./modules/modules.nix
                  ];
                  home.stateVersion = "23.05";
                };
              }
            ];
          };
        };

        # All home-manager configurations are kept here.
        homeModules = {
          # Common home-manager configuration shared between Linux and macOS.
          common = {pkgs, ...}: {
            programs.git.enable = true;
            programs.starship.enable = true;
            programs.zsh.enable = true;
          };
          # home-manager config specific to NixOS
          linux = {
            xsession.enable = true;
          };
        };
      };
    };
}
