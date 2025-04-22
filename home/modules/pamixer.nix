{ nixpkgs-master, ... }:
{ pkgs, ... }:
{
  home.packages = [
    nixpkgs-master.legacyPackages.${pkgs.system}.pamixer
  ];
}
