inputs: {
  "programs/nixpkgs" = import ./programs/nixpkgs inputs;
  "home" = import ./home.nix inputs;
}
