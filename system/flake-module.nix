{
  self,
  inputs,
  ...
}: let
  inherit (inputs.nixpkgs) lib;
  inherit (inputs) nixpkgs;

  nixosSystem = args:
    (lib.makeOverridable lib.nixosSystem)
    (lib.recursiveUpdate args {
      modules =
        args.modules
        ++ [
          {
            config.nixpkgs.pkgs = lib.mkDefault args.pkgs;
            config.nixpkgs.localSystem = lib.mkDefault args.pkgs.stdenv.hostPlatform;
          }
        ];
    });

  defaultModules = [
    # make flake inputs accessiable in NixOS
    {
      _module.args.self = self;
      _module.args.inputs = self.inputs;
    }
    ({pkgs, ...}: {
      nix.nixPath = [
        "nixpkgs=${pkgs.path}"
        "home-manager=${inputs.home-manager}"
        "nur=${inputs.nur}"
      ];

      documentation.info.enable = false;

      imports = [
        ./modules/nix-daemon.nix
        ./modules/hidpi.nix
        ./modules/misc.nix
        inputs.nur.nixosModules.nur
        inputs.sops-nix.nixosModules.sops
      ];
    })
  ];
in {
  flake.nixosConfigurations = {
    chestnut = nixosSystem {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules =
        defaultModules
        ++ [
          inputs.nixos-hardware.nixosModules.common-cpu-amd
          inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
          inputs.nixos-hardware.nixosModules.common-gpu-amd

          inputs.home-manager.nixosModules.home-manager
          ./configuration.nix
        ];
    };
  };
}
