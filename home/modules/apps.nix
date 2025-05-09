{
  unstable,
  self,
  ...
}:
{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = {
    nix.allowedUnfree = [
      "steam"
      "logseq"
      "unrar"
    ];

    home.packages = with pkgs; [
      # wayland
      qt5.qtwayland
      qt6.qtwayland

      oculante # image viewer (rust)

      dconf
      feh
      # browsers
      firefox-devedition
      brave

      yazi

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

      # apps
      logseq

      # Programming
      gnumake
      cmake
      gh
      asdf-vm
      difftastic
      delta

      # Nix
      nix-prefetch-git
      nixd

      # CLI
      ripgrep
      dust
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
