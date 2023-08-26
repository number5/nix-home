{pkgs, ...}: {
  home.packages = with pkgs; [
    wezterm
    kitty
    firefox
    xfce.thunar
    lxappearance
    vlc
    htop-vim
    nvtop
    feh
    playerctl
    xbanish
    neofetch
    xclip
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
