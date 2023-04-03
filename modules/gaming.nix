{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    bottles
    dosbox
    protontricks
    protonup-ng
    shattered-pixel-dungeon
    wine64
    winetricks
  ];
}
