{self, ...}: {
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    steam
    steam-tui
    dosbox
    protontricks
    shattered-pixel-dungeon
  ];
}
