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
    ./catppuccin.nix
  ];

  config = {
    # display.enable = true;

    programs.home-manager.enable = true;

    modules.eww.enable = true;

    home.enableNixpkgsReleaseCheck = false;

    mutable = {
      enable = true;

      repos = {
        asdf = {
          branch = "v0.16.7";
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
