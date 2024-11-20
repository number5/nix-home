{
  neovim-nightly-overlay,
  pkgs,
  ...
}: {
  programs.neovim = {
    package = neovim-nightly-overlay.packages.${pkgs.system}.default;
    enable = true;
    vimAlias = true;
  };
}
