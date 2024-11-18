inputs: {
  "home" = import ./home.nix inputs;
  "wezterm" = import ./wezterm inputs;
  "programs/nixpkgs" = import ./programs/nixpkgs inputs;
  "mutablerepos" = import ./mutablerepos.nix inputs;

  #  "i3" = import ./i3 inputs;
  # "polybar" = import ./polybar inputs;
  "hyprland" = import ./wayland/hyprland inputs;
  "libvirt" = import ./libvirt.nix inputs;
  "apps" = import ./apps.nix inputs;
  "dunst" = import ./dunst inputs;
  "eww" = import ./wayland/eww inputs;
  "foot" = import ./foot inputs;
  "way-displays" = import ./way-displays inputs;

  "dotfiles" = import ./dotfiles inputs;
}
