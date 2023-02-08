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
      modules = [
        {
          _module.args.self = self;
          _module.args.inputs = self.inputs;
          imports =
            extraModules
            ++ [
              ./common.nix
              inputs.nur.hmModules.nur
            ];
          home.username = "bruce";
          home.homeDirectory = "/home/bruce";
        }
      ];
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    });
  in {
    apps.hm = {
      type = "app";
      program = "${pkgs.writeShellScriptBin "hm" ''
        set -x
        export PATH=${pkgs.lib.makeBinPath [pkgs.git pkgs.coreutils pkgs.nix pkgs.jq pkgs.unixtools.hostname]}
        declare -A profiles=(["chestnut"]="chestnut")
        profile="common"
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
          common = homeManagerConfiguration {};
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
