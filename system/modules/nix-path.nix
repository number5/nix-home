{inputs, ...}: {
  nix.nixPath = [
    "nixpkgs=${inputs.nixpkgs}"
    "home-manager=${inputs.home-manager}"
    "nur=${inputs.nur}"
  ];
}