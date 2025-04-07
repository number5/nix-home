let
  user = "bruce";
  name = "Bruce Wong";
  idno = 1000;
in
{
  config = {
    nix.settings.trusted-users = [ user ];

    security.sudo.wheelNeedsPassword = false;

    users.extraGroups."${user}".gid = idno;
    users.extraUsers."${user}" = {
      isNormalUser = true;
      home = "/home/${user}";
      description = name;
      openssh.authorizedKeys.keys = [
        # gpg card
        # /run/secrets/hydra_queue_runner_id_rsa.pub
      ];
      #mkpasswd -m sha-512
      extraGroups = [
        "wheel"

        "kvm"
        "libvirtd"
        "qemu-libvirtd"
        "docker"
        "podman"

        "audio"
        "video"
        "sound"
        "pulse" # ??
        "input"
        "networkmanager"
        "scard"
        "tty"
        "users" # ??
        "network" # ? networkctl
        "netdev" # actually networkctl
        "flashrom"
        "adbusers"
      ];
      uid = idno;
      group = user;
    };
  };
}
