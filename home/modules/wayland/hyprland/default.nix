{
  self,
  eww,
  anyrun,
  ...
}: {
  config,
  pkgs,
  lib,
  ...
}: let
  hypr-config = import ./config.nix {
    inherit
      eww
      anyrun
      lib
      config
      pkgs
      ;
  };
  rules = import ./rules.nix;
in {
  options.bw.eww = {
    enable = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "Enable eww";
    };
  };

  imports = [rules];
  config =
    {
      bw.eww.enable = true;
      home = {
        packages = with pkgs; [
          seatd
          jaq
        ];
      };
    }
    // hypr-config;
}
