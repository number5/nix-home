{
  description = "NixOS configuration with flakes";

  # To update all inputs:
  # $ nix flake update
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-systemd.url = "github:pennae/nixpkgs/systemd-oom";
    nur.url = "github:nix-community/NUR";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Nix linter
    statix = {
      url = "github:nerdypepper/statix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    flake-parts,
    nixpkgs,
    ...
  }:
    (flake-parts.lib.evalFlakeModule
      {inherit inputs;}
      {
        imports = [
          ./system/flake-module.nix
          ./home/flake-module.nix
          ./devshell/flake-module.nix
        ];
        systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin"];
        perSystem = {
          config,
          inputs',
          system,
          ...
        }: {
          # make pkgs available to all `perSystem` functions
          _module.args.pkgs = inputs'.nixpkgs.legacyPackages;

          formatter = config.treefmt.build.wrapper;
        };
        # CI
        flake.hydraJobs = let
          inherit (nixpkgs) lib;
          buildHomeManager = arch:
            lib.mapAttrs' (name: config: lib.nameValuePair "home-manager-${name}-${arch}" config.activation-script) self.legacyPackages.${arch}.homeConfigurations;
        in
          (lib.mapAttrs' (name: config: lib.nameValuePair "nixos-${name}" config.config.system.build.toplevel) self.nixosConfigurations)
          // (buildHomeManager "x86_64-linux")
          // (buildHomeManager "aarch64-linux")
          // (buildHomeManager "aarch64-darwin")
          // {
          };
      })
    .config
    .flake;
}
