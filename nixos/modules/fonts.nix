{self, ...}: {
  pkgs,
  config,
  ...
}: {
  _file = ./fonts.nix;
  fonts.fontconfig.enable = true;

  environment.systemPackages = with pkgs; [
    iosevka
    sarasa-gothic
    roboto-mono
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    jetbrains-mono
  ];
}
