inputs: {
  "home" = import ./home.nix inputs;
  "programs/nixpkgs" = import ./programs/nixpkgs inputs;
  "mutablerepos" = import ./mutablerepos.nix inputs;
}
