{self, ...}: {
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    heroic
    steam
    gamescope
    dosbox
    protontricks
    shattered-pixel-dungeon
  ];
}
