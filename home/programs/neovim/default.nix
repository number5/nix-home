{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    xdg.configFile."nvim" = {
      source = "${dot_zsh}/";
      recursive = true;
    };
  };
}
