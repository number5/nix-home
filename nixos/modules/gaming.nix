{self, ...}: {
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    steam
    dosbox
    protontricks
    shattered-pixel-dungeon
  ];
}
