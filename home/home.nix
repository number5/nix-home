{ pkgs, system, home-manager, username, stateVersion, ... }:

let
  stablePackages = with pkgs; [
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
  unstablePackages = with pkgs.unstable; [
    # Applications
    ledger-live-desktop
    #Libraries
    ffmpeg-full
  ];
in {
  ${username} = home-manager.lib.homeManagerConfiguration {
    inherit pkgs system username stateVersion;
    homeDirectory = "/home/${username}";
    configuration = {
      programs.home-manager.enable = true;
      services.blueman-applet.enable = true;

      home.packages = stablePackages ++ unstablePackages;

      # Restart services on change
      systemd.user.startServices = "sd-switch";

      imports = (import ./programs) ++ (import ./services);
    };
  };
}
