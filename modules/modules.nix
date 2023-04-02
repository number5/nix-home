{pkgs, ...}: {
  imports =
    [
      ./libvirt.nix
    ]
    ++ (
      if pkgs.stdenv.isLinux
      then [
        # NixOS only
        #./bspwm
      ]
      else []
    );
}
