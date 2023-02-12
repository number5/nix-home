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
    home.packages = with pkgs; [
      # Applications
      vlc

      # Desktop
      htop-vim
      nvtop
      feh
      playerctl
      xbanish
      neofetch
      xclip
      ripgrep
      xmousepasteblock
      jq
      unzip
      p7zip
      unrar

      # Programming
      asdf-vm
      nix-prefetch-git
      yarn
      rnix-lsp
      postman
      nasm
      esbuild
    ];
    #  unstablePackages = with pkgs.unstable; [
    #    # Applications
    #    ledger-live-desktop
    #    #Libraries
    #    ffmpeg-full
    #  ];

    home.enableNixpkgsReleaseCheck = false;

    home.stateVersion = "22.11";
    home.username = "bruce";
    home.homeDirectory = "/home/bruce";
    programs.home-manager.enable = true;
  };
}
