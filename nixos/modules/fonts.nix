{ self, ... }:
{
  pkgs,
  config,
  ...
}:
{
  _file = ./fonts.nix;

  fonts.fontconfig = {
    enable = true;
    useEmbeddedBitmaps = true;
    antialias = true;
    hinting = {
      enable = true;
      style = "full";
      autohint = true;
    };
    subpixel = {
      rgba = "rgb";
      lcdfilter = "default";
    };
  };

  fonts.packages = with pkgs; [
    iosevka-bin
    jetbrains-mono
    material-design-icons # fonts with glyphs
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    roboto-mono
    sarasa-gothic
    open-sans
    inter
    fira-code
    fira-code-symbols
    # nerd fonts
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono

    font-awesome # awesome fonts
  ];
}
