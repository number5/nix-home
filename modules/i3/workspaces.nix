{ config, lib, pkgs, ... }:
{

  options.workspaces = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
  };

  config = {
    # Number at the start is used for ordering
    # https://github.com/Alexays/Waybar/blob/f233d27b782c04ef128e3d71ec32a0b2ce02df39/src/modules/sway/workspaces.cpp#L351-L357
    i3.workspaces = lib.mkDefault {
      WS1 = "1:";      # browsing
      WS2 = "2:";      # school
      WS3 = "3:";      # dev
      WS4 = "4:";      # sysadmin
      WS5 = "5:";      # gaming
      WS6 = "6:";      # movie
      WS7 = "7:";      # social
      WS8 = "8";        # scratchpad
      WS9 = "9";        # scratchpad
      WS10 = "10";      # scratchpad
    };

    };
}
