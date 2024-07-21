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
    eww = eww;
    anyrun = anyrun;
    lib = lib;
    config = config;
    pkgs = pkgs;
  };
  rules = import ./rules.nix;
in {
  imports = [rules];
  config =
    {
      home = {
        packages = with pkgs; [
          seatd
          jaq
        ];
      };
    }
    // hypr-config;
}
