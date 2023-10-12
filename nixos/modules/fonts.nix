{self, ...}: {
  pkgs,
  config,
  ...
}: {
  _file = ./fonts.nix;
  fonts.fontconfig.enable = true;

  environment.systemPackages = with pkgs; [
    (nerdfonts.override {fonts = ["JetBrainsMono" "Noto"];})
    source-han-mono
    source-han-serif
    roboto-mono
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    jetbrains-mono
  ];
}
