{
  pkgs,
  ...
}: {
  programs.neovim = {
    package = pkgs.neovim-nightly;
    enable = true;
    vimAlias = true;
  };
}
