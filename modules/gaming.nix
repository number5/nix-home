{
  pkgs,
  flake,
  ...
}: {
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    steam-tui
    dosbox
    protontricks
    shattered-pixel-dungeon
  ];
}
