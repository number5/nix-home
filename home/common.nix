{
  pkgs,
  config,
  lib,
  ...
}: {
  imports =
    [
      #./modules/neovim.nix
    ]
    ++ (import ./programs)
    ++ (import ./services);

  config = {
    #  unstablePackages = with pkgs.unstable; [
    #    # Applications
    #    ledger-live-desktop
    #    #Libraries
    #    ffmpeg-full
    #  ];

    home.enableNixpkgsReleaseCheck = false;

    home.stateVersion = "23.05";
    home.username = "bruce";
    home.homeDirectory = "/home/bruce";
    programs.home-manager.enable = true;

    mutable = {
      enable = true;

      repos = {
        asdf = {
          branch = "v0.10.1";
          repo = "https://github.com/asdf-vm/asdf.git";
          target = "${config.home.homeDirectory}/.asdf";
        };

        dot_nvim = {
          branch = "main";
          repo = "ssh://git@github.com:number5/dot_vim.git";
          target = "${config.xdg.configHome}/nvim";
        };
      };
    };
  };
}
