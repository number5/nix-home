{
  flake,
  pkgs,
  lib,
  ...
}: {
  nixpkgs = {
    config = {
      allowBroken = true;
      allowUnsupportedSystem = true;
      allowUnfree = true;
    };
    overlays = [
      flake.inputs.nuenv.overlays.nuenv
      flake.inputs.nixd.overlays.default
      flake.inputs.nuenv.overlays.default
    ];
  };

  nix = {
    # Flakes settings
    package = pkgs.nixVersions.git;
    registry.nixpkgs.flake = flake.inputs.nixpkgs;
    nixPath = ["nixpkgs=${flake.inputs.nixpkgs}"]; # Enables use of `nix-shell -p ...` etc

    settings = {
      max-jobs = "auto";
      experimental-features = "nix-command flakes";
      # I don't have an Intel mac.
      extra-platforms = lib.mkIf pkgs.stdenv.isDarwin "aarch64-darwin x86_64-darwin";
      # Nullify the registry for purity.
      flake-registry = builtins.toFile "empty-flake-registry.json" ''{"flakes":[],"version":2}'';

      # Cachix
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      trusted-users = ["@wheel" "root" "bruce"];

      fallback = true;
      warn-dirty = false;
      auto-optimise-store = true;
    };
  };
}
