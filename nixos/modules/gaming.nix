{self, ...}: {
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    heroic
    steam
    dosbox
    protontricks
    shattered-pixel-dungeon
  ];
}
