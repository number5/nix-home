{
  unstable,
  self,
  ...
}: {
  config,
  pkgs,
  lib,
  ...
}: let
  self' = self.packages.${pkgs.system};
in {
  _file = ./default.nix;

  fonts.fontconfig.enable = true;

  systemd.user = {
    # sessionVariables = { NIX_PATH = nixPath; };
  };

  # xsession.windowManager.awesome.enable = true;

  home = {
    # sessionVariables = { NIX_PATH = nixPath; };

    packages = let
      p = pkgs;
      s = self';
    in [
      p.cachix
      p.exercism

      p.fira-code

      p.lefthook
    ];

    stateVersion = "23.11";
  };
}
