inputs:
let
  pkgs = inputs.unstable.legacyPackages.x86_64-linux;

  callPackage = pkgs.lib.callPackageWith (pkgs // { inherit (inputs) self; });
in
{
  statix = callPackage ./statix.nix { };
}
