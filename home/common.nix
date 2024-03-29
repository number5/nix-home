{
  pkgs,
  config,
  lib,
  ...
}: {
  imports =
    [
      ./i3
      ./mutablerepos.nix
      ./libvirt.nix
      ./apps.nix
      ./polybar
      ./dunst
    ]
    ++ (import ./programs)
    ++ (import ./services);

  home = {
    enableNixpkgsReleaseCheck = false;

    username = "bruce";
    homeDirectory = "/home/bruce";
  };

  config = {
    #  unstablePackages = with pkgs.unstable; [
    #    # Applications
    #    ledger-live-desktop
    #    #Libraries
    #    ffmpeg-full
    #  ];
    programs.home-manager.enable = true;

    mutable = {
      enable = true;

      repos = {
        asdf = {
          branch = "v0.12.0";
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
