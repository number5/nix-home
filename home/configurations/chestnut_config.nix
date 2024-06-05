{
  pkgs,
  # inputs,
  ...
}: {
  display = {
    enable = true;

    monitors = {
      main = {
        name = "eDP-1";
        wallpaper = ../../wallpapers/Kanagawa.jpg;
        width = 2560;
        height = 1600;
      };
    };

    keyboards = [
      "logitech-g915-tkl-lightspeed-wireless-rgb-mechanical-gaming-keyboard"
      "logitech-usb-receiver-keyboard"
    ];
    mouseSensitivity = 0.00;

    screenshotKeybinds = {
      active = ", XF86LaunchA";
      area = "SHIFT, XF86LaunchA";
      # all = ", XF86LaunchB";
    };
  };
}
