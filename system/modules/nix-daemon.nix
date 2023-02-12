{
  lib,
  config,
  ...
}: {
  # this extends srvos's common settings
  nix = {
    gc.automatic = true;
    gc.dates = "03:15";
    gc.options = "--delete-older-than 10d";
    # should be enough?
    nrBuildUsers = lib.mkDefault 32;

    settings = {
      # for nix-direnv
      keep-outputs = true;
      keep-derivations = true;

      # in zfs we trust
      fsync-metadata = lib.boolToString (!config.boot.isContainer or config.fileSystems."/".fsType != "zfs");
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      trusted-users = ["@wheel" "root"];

      fallback = true;
      warn-dirty = false;
      auto-optimise-store = true;
    };
  };

  #imports = [
  #  ./builder.nix
  #];

  programs.command-not-found.enable = false;
}
