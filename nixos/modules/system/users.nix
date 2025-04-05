 {
  users.extraUsers = {
    bruce = {
      isNormalUser = true;
      home = "/home/bruce";
      extraGroups = ["audio" "wheel" "docker" "plugdev" "libvirtd" "adbusers" "input" "kvm" "wireshark"];
      shell = "/run/current-system/sw/bin/zsh";
      uid = 1000;
       # openssh.authorizedKeys.keys = keys;
    };

     # root.openssh.authorizedKeys.keys = keys;
  };

   # boot.initrd.network.ssh.authorizedKeys = keys;

  security.sudo.wheelNeedsPassword = false;
}
