{
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./configuration.nix
    ../../modules/system/users.nix
    ../../modules/system/libvirtd.nix
    ../../modules/system/misc.nix
    ../../modules/system/nix-daemon.nix
    ../../modules/system/pipewire.nix
    ../../modules/system/xrdb.nix
    ../../modules/system/zsh.nix
    ../../modules/system/gui-support.nix
  ];

  environment.systemPackages = [];

  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.persistent = true;
  nix.gc.randomizedDelaySec = "30min";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "23.11"; # Did you read the comment?

  time.timeZone = lib.mkDefault "Australia/Melbourne";
}
