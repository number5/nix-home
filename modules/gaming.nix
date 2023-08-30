{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    bottles
    dosbox
    protontricks
    shattered-pixel-dungeon
  ];
}
