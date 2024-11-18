{
  unstable,
  self,
  ...
}: {
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    nixpkgs.allowedUnfree = ["steam" "logseq" "unrar"];

    home.packages = with pkgs; [
      dconf
      feh
      firefox
      haskellPackages.greenclip
      htop-vim
      jq
      kitty
      lxappearance
      neofetch
      p7zip
      playerctl
      rofi
      rofimoji
      unrar
      unzip
      vlc
      xbanish
      xclip
      xdotool
      xfce.thunar
      xmousepasteblock
      xsecurelock
      xss-lock

      # Programming
      gnumake
      cmake
      gh
      asdf-vm
      difftastic

      # Nix
      nix-prefetch-git
      nixd

      # CLI
      ripgrep
      file
      bat
      eza
      fzf
      fd
      starship
      tmux
      sudo
    ];

    xdg.mimeApps = {
      enable = true;

      defaultApplications = {
        "text/html" = "firefox.desktop";
        "text/xml" = "firefox.desktop";
        "application/xhtml_xml" = "firefox.desktop";
        "image/webp" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/ftp" = "firefox.desktop";
      };
    };
  };
}
