_:
{
  pkgs,
  config,
  ...
}:
{
  config = {
    home.packages = with pkgs; [
      fira-code
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
