_: {
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./binds.nix
    ./rules.nix
    ./settings.nix
  ];

  # enable hyprland
  wayland.windowManager.hyprland = {
    enable = true;

    # plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
    #   # hyprbars
    #   # hyprexpo
    # ];

    systemd = {
      variables = ["--all"];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
