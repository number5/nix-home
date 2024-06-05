{
  unstable,
  self,
  ...
}: {
  config,
  pkgs,
  ...
}: {
  _file = ./bruce_at_chestnut.nix;

  imports = [
    ./chestnut_config.nix
  ];

  config = {
    home.packages = builtins.attrValues {
      inherit (pkgs) neovim;
    };

    mutable = {
      enable = true;

      repos = {
        asdf = {
          branch = "v0.13.1";
          repo = "https://github.com/asdf-vm/asdf.git";
          target = "${config.home.homeDirectory}/.asdf";
        };

        dot_nvim = {
          branch = "main";
          repo = "git@github.com:number5/dot_vim.git";
          target = "${config.xdg.configHome}/nvim";
        };
      };
    };
  };
}
