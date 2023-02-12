{
  pkgs,
  config,
  ...
}: {
  config = {
    home.packages = with pkgs; [
      bottles
      dosbox
      protontricks
      protonup-ng
      shattered-pixel-dungeon
      wine64
      winetricks
    ];
  };
}
