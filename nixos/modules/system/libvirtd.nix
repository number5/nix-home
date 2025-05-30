{ pkgs, ... }:
{
  config = {
    security.polkit.enable = true;

    virtualisation.libvirtd = {
      enable = true;
      onBoot = "ignore";
      qemu.runAsRoot = false;
      qemu.package = pkgs.qemu_kvm;
      extraConfig = ''
        unix_sock_group = "libvirtd"
      '';
    };

    virtualisation.spiceUSBRedirection.enable = true;
  };
}
