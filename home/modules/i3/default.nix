{
  unstable,
  self,
  ...
}:
{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = {
    xsession = {
      enable = true;

      windowManager = {
        i3 = import ./i3-config.lib.nix { inherit config pkgs lib; };
      };

      initExtra = ''
        exec &> ~/.xsession-errors

        # fix the look of Java applications
        export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
      '';

      scriptPath = ".hm-xsession";
    };
  };
}
