let
  keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHakzqHkKOPapGRxmlOhcK/EbL60l+pv8AyF0ssQqsRK bruce@CA"
  ];
in
{
  users.extraUsers = {
    bruce = {
      isNormalUser = true;
      home = "/home/bruce";
      extraGroups = [ "audio" "wheel" "docker" "plugdev" "vboxusers" "adbusers" "input" "kvm" "wireshark" ];
      shell = "/run/current-system/sw/bin/zsh";
      uid = 1000;
      openssh.authorizedKeys.keys = keys;
    };

    root.openssh.authorizedKeys.keys = keys;
  };

  boot.initrd.network.ssh.authorizedKeys = keys;

  security.sudo.wheelNeedsPassword = false;

  imports = [ ./zsh.nix ];
}
