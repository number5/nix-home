{pkgs, ...}: {
  home.packages = with pkgs; [
    dconf
    dunst
    feh
    firefox
    haskellPackages.greenclip
    htop-vim
    jq
    kitty
    lxappearance
    neofetch
    nvtop
    p7zip
    playerctl
    rofi
    rofimoji
    unrar
    unzip
    vlc
    wezterm
    xbanish
    xclip
    xdotool
    xfce.thunar
    xmousepasteblock
    xsecurelock
    xss-lock

    # Programming
    asdf-vm
    nix-prefetch-git
    yarn
    rnix-lsp
    postman

    # CLI
    ripgrep
    file
    bat
    exa
    fzf
    fd
    starship
    tmux
    sudo

    # Security
    _1password
    _1password-gui

    logseq
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
}
