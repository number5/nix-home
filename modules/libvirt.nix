{pkgs, ...}: {
  config = {
    virtualisation.spiceUSBRedirection.enable = true;
    #security.wrappers.spice-client-glib-usb-acl-helper.source =
    #  "${pkgs.spice-gtk}/bin/spice-client-glib-usb-acl-helper";

    home.packages = with pkgs; [
      virt-manager
      virt-viewer
    ];
  };
}
