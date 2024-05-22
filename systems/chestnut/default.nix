{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./configuration.nix
    ../../modules/system/users.nix
    ../../modules/system/libvirtd.nix
    ../../modules/system/misc.nix
    ../../modules/system/pipewire.nix
    ../../modules/system/xrdb.nix
    ../../modules/system/zsh.nix
    ../../modules/system/gui-support.nix
  ];

  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  nix = {
  # Automate garbage collection
  gc =  {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  persistent = true;
  randomizedDelaySec = "30min";
};
  };

  services.fwupd.enable = true;
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "23.11"; # Did you read the comment?

  time.timeZone = lib.mkDefault "Australia/Melbourne";

  systemd.services = {
    ath11k-fix = {
      enable = true;

      description = "Suspend fix for ath11k_pci";
      before = ["sleep.target"];

      unitConfig = {
        StopWhenUnneeded = "yes";
      };

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = "yes";
        ExecStart = "/run/current-system/sw/bin/modprobe -r ath11k_pci";
        ExecStop = "/run/current-system/sw/bin/modprobe ath11k_pci";
      };

      wantedBy = ["sleep.target"];
    };
  };
}
