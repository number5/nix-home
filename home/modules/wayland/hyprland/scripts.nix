{ lib, writeShellScriptBin }:

let
  intMonitor = "DP-1";
  extMonitor = "DP-2";

  monitorsConf = "$XDG_CONFIG_HOME/hypr/monitors.conf";

  monitorAdded = writeShellScriptBin "monitor-added" ''
    hyprctl --batch "\
      dispatch moveworkspacetomonitor 1 ${extMonitor};\
      dispatch moveworkspacetomonitor 2 ${extMonitor};\
      dispatch moveworkspacetomonitor 3 ${extMonitor};\
      dispatch moveworkspacetomonitor 4 ${extMonitor};\
      dispatch moveworkspacetomonitor 5 ${extMonitor};\
      dispatch moveworkspacetomonitor 6 ${extMonitor}"
    ${lib.getExe monitorConnected}
  '';

  monitorConnected = writeShellScriptBin "monitor-connected" ''
    hyprctl dispatch dpms off ${intMonitor}
    echo "monitor=${extMonitor},highres@50,0x0,1" > ${monitorsConf}
    echo "monitor=${intMonitor},preferred,auto-right,1" >> ${monitorsConf}
  '';

  monitorRemoved = writeShellScriptBin "monitor-removed" ''
    hyprctl dispatch dpms on ${intMonitor}
    echo "monitor=${intMonitor},preferred,0x0,1" > ${monitorsConf}
  '';
in
{
  inherit extMonitor monitorAdded monitorRemoved;

  wsNix = writeShellScriptBin "ws-nix" ''
    footclient -D ~/workspace/nix-config -E fish -C 'hyfetch' &
    footclient -D ~/workspace/nix-config -E fish -C 'nitch' &
  '';

  monitorInit = writeShellScriptBin "monitor-init" ''
    monitors=$(hyprctl monitors)
    if [[ $monitors == *"${extMonitor}"* ]]; then
      ${lib.getExe monitorConnected}
    else
      ${lib.getExe monitorRemoved}
    fi
  '';
}
