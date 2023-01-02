{
  description = "NixOS flake configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, unstable, home-manager, ... }:
    let
      username = "bruce";
      hostName = "chestnut";
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
        permittedInsecurePackages = ["libav-11.12"];
      };
      localOverlay = prev: final: {
        unstable = import unstable { 
          inherit config;
          system = final.system; 
        };
      };
      pkgs = import nixpkgs {
        inherit system config;
        overlays = [ localOverlay ];
      };
      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      stateVersion = "22.11"; # Did you read the comment?
    in {
      nixosConfigurations = import ./system/configuration.nix {
        inherit pkgs system username hostName stateVersion;
        lib = nixpkgs.lib;
      };
      homeConfigurations."${username}}@${hostName}" = homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./home/home.nix
          {
            home = {
              username = username;
              homeDirectory = "/home/${username}";
              stateVersion = "22.11";
            };
          }
        ];
      };
    };
}
