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
    font-awesome # awesome fonts
    iosevka-bin
    jetbrains-mono
    material-design-icons # fonts with glyphs
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    roboto-mono
    sarasa-gothic
    open-sans
    inter
  ];
}
