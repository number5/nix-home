{
  pkgs,
  config,
  lib,
  ...
}: {
  imports =
    [
      #./modules/neovim.nix
    ]
    ++ (import ./programs)
    ++ (import ./services);

  config = {
    #  unstablePackages = with pkgs.unstable; [
    #    # Applications
    #    ledger-live-desktop
    #    #Libraries
    #    ffmpeg-full
    #  ];

    home.enableNixpkgsReleaseCheck = false;

    home.stateVersion = "23.05";
    home.username = "bruce";
    home.homeDirectory = "/home/bruce";
    programs.home-manager.enable = true;
  };
}
