{self, ...} @ inputs: {pkgs, ...}: {
  programs.anyrun = let
    debug = builtins.trace "anyrun package inputs: " inputs;
  in {
    enable = true;

    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        shell
        translate
      ];

      width.fraction = 0.3;
      y.absolute = 15;
      hidePluginInfo = true;
      closeOnClick = true;
    };

    extraCss = builtins.readFile (./. + "/style-dark.css");

    extraConfigFiles."applications.ron".text = ''
      Config(
        desktop_actions: false,
        max_entries: 5,
        terminal: Some("wezterm"),
      )
    '';
  };
}
