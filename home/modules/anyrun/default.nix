{
  self,
  anyrun,
  ...
}: {pkgs, ...}: let
  package = anyrun.packages.${pkgs.system}.anyrun-with-all-plugins;
in {
  programs.anyrun = {
    enable = true;

    package = package;
    config = {
      plugins = [
        "${package}/lib/libapplications.so"
        "${package}/lib/librink.so"
        "${package}/lib/libshell.so"
        "${package}/lib/libdictionary.so"
        "${package}/lib/libsymbols.so"
        "${package}/lib/libtranslate.so"
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
