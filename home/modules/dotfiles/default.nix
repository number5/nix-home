_: {
  pkgs,
  config,
  ...
}: {
  config = {

    xdg = {
      enable = true;
      configFile."git/config".source = ./gitconfig;
      configFile."git/gitconfig-number5".source = ./gitconfig-number5;
    };
  };
}
