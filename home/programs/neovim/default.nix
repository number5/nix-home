{ pkgs, ... }:


in {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = (builtins.readFile ./init.vim) + '';
  };
}
