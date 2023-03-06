{pkgs, inputs, ...}: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
  };

    xdg.configFile."nvim" = {
      source = "${inputs.dot_vim}/";
      recursive = true;
    };
}
