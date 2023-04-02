{
  inputs,
  lib,
  self,
  withSystem,
  ...
}: {
  flake = {
    nixosConfigurations = withSystem "x86_64-linux" ({
      pkgs,
      system,
      ...
    }: let
      mkNixOs = machineConfig:
        inputs.nixpkgs.lib.nixosSystem {
          inherit pkgs system;

          modules = [
            {
              config._module.args = {
                inherit inputs;
                flake = self;
              };
            }
            inputs.nixpkgs.nixosModules.notDetected
            inputs.home-manager.nixosModules.home-manager
            machineConfig
            (_: {
              nix.registry =
                builtins.mapAttrs (_name: flake: {inherit flake;}) inputs;
            })
          ];
        };
    in {
      chestnut = mkNixOs ../system/machines/chestnut;
    });

    packages.x86_64-linux = lib.attrsets.mapAttrs' (name: value:
      lib.attrsets.nameValuePair "nixos-${name}"
      value.config.system.build.toplevel)
    self.outputs.nixosConfigurations;
  };
}
