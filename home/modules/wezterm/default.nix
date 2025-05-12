_:
{
  pkgs,
  config,
  ...
}:
{
  config = {
    home.packages = with pkgs; [
      wezterm
    ];

    xdg = {
      enable = true;
      configFile = {
        wezterm_lua = {
          target = "wezterm/wezterm.lua";
          source = ./wezterm.lua;
        };
      };
    };
  };
}
