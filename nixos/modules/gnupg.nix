{self, ...}: {
  pkgs,
  config,
  ...
}: {
  _file = ./gnupg.nix;

  hardware.gpgSmartcards.enable = true;
  hardware.ledger.enable = true; # probably unrelated
  services.udev.packages = [pkgs.yubikey-personalization];
  services.pcscd.enable = true;

  environment.systemPackages = with pkgs; [
    yubikey-manager
    gnupg
    pinentry
  ];
}
