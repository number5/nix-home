{self, ...}: {
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    heroric
    steam
    dosbox
    protontricks
    shattered-pixel-dungeon
  ];
}
