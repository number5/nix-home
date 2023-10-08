inputs: {
  _file = ./default.nix;

  "programs/nixpkgs" = import ./programs/nixpkgs inputs;
}
