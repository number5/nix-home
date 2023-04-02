{
  self,
  inputs,
  ...
}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: let
    homeManagerConfiguration = {
      extraModules ? [],
      system ? "x86_64-linux",
    }: (inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import self.inputs.nixpkgs {
        inherit system;
        # overlays = [self.overlays.default];
        config.allowUnfree = true;
      };
      modules = [
        {
          _module.args.self = self;
          _module.args.inputs = self.inputs;
          imports =
            extraModules
            ++ [
              ../home/common.nix
              ../modules/modules.nix
              inputs.nur.hmModules.nur
            ];
          home.username = "bruce";
          home.homeDirectory = "/home/bruce";
        }
      ];
      # pkgs = inputs.nixpkgs.legacyPackages.${system};
    });
  in {
    apps.hm = {
      type = "app";
      program = "${pkgs.writeShellScriptBin "hm" ''
        set -x
        export PATH=${pkgs.lib.makeBinPath [pkgs.git pkgs.coreutils pkgs.nix pkgs.jq pkgs.unixtools.hostname]}
        declare -A profiles=(["chestnut"]="chestnut")
        profile="bruce"
        hostname
        if [[ -n ''${profiles[$(hostname)]:-} ]]; then
          profile=''${profiles[$(hostname)]}
        fi
        ${inputs.home-manager.packages.${pkgs.system}.home-manager}/bin/home-manager --flake "${self}#$profile" "$@"
      ''}/bin/hm";
    };
    legacyPackages = {
      homeConfigurations =
        {
          bruce = homeManagerConfiguration {};
        }
        // lib.optionalAttrs (pkgs.hostPlatform.system == "x86_64-linux") {
          chestnut = homeManagerConfiguration {
            extraModules = [
              inputs.nix-index-database.hmModules.nix-index
              ({pkgs, ...}: {
                home.packages = [
                ];
              })
            ];
          };
        };
    };
  };
}
