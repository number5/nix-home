{ pkgs, config, ... }:

{
  config = {
    programs.steam.enable = true;

    home.packages = with pkgs;
        [
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
