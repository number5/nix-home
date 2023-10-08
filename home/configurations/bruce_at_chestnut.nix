{self, ...}: {
  pkgs,
  lib,
  ...
}: {
  _file = ./bruce_at_chestnut.nix;

  nixpkgs.allowedUnfree = ["steam" "logseq"];

  home.packages = builtins.attrValues {
    inherit (pkgs) neovim;
  };
}
