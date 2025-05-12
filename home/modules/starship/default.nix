_:
{
  pkgs,
  config,
  ...
}:
{
  config = {
    home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

    home.packages = [ pkgs.starship ];

    home.file.".config/starship.toml".source = ./starship.toml;
  };

}
