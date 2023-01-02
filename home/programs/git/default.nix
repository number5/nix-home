{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = "number5@users.noreply.github.com";
    userName = "number5";
    extraConfig = {
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
