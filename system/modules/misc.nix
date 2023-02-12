{
  config,
  pkgs,
  lib,
  ...
}: {
  users.users = {
    bruce = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHakzqHkKOPapGRxmlOhcK/EbL60l+pv8AyF0ssQqsRK"
      ];
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
        "audio"
      ];
    };
  };
  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    # Forbid root login through SSH.
    permitRootLogin = "no";
    # Use keys only. Remove if you want to SSH using password (not recommended)
    passwordAuthentication = false;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
