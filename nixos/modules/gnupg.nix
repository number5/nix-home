{self, ...}: {
  pkgs,
  config,
  ...
}: {
  _file = ./gnupg.nix;

  services = {
    pcscd.enable = true;
    udev.packages = [ pkgs.yubikey-personalization ];
};
  
     environment.systemPackages = with pkgs; [
    yubikey-manager
    gnupg
    pinentry
  ];
  
}
