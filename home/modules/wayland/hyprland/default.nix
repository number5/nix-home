_: {
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./config.nix
    ./rules.nix
  ];

  home = {
    packages = with pkgs; [
      seatd
      jaq
    ];
  };
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
