{
  pkgs,
  flake,
  ...
}: {
  programs.steam = {
    # enable steam as usual
    enable = true;

    # add extra compatibility tools to your STEAM_EXTRA_COMPAT_TOOLS_PATHS using the newly added `extraCompatPackages` option
    extraCompatPackages = [
      # add the packages that you would like to have in Steam's extra compatibility packages list
      # pkgs.luxtorpeda
      flake.inputs.nix-gaming.packages.${pkgs.system}.proton-ge
      # etc.
    ];
  };

  environment.systemPackages = with pkgs; [
    dosbox
    protontricks
    shattered-pixel-dungeon
  ];
}
