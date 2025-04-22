{ self, ... }:
{
  pkgs,
  config,
  ...
}:
{
  _file = ./fonts.nix;
  fonts.fontconfig.enable = true;

  environment.systemPackages = with pkgs; [
    iosevka
    roboto-mono
    jetbrains-mono
  ];
}
