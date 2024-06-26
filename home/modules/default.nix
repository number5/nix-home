inputs: {
  "home" = import ./home.nix inputs;
  "wezterm" = import ./wezterm inputs;
  "programs/nixpkgs" = import ./programs/nixpkgs inputs;
  "mutablerepos" = import ./mutablerepos.nix inputs;

  #  "i3" = import ./i3 inputs;
  # "polybar" = import ./polybar inputs;
  "libvirt" = import ./libvirt.nix inputs;
  "apps" = import ./apps.nix inputs;
  "dunst" = import ./dunst inputs;
  "anyrun" = import ./anyrun inputs;
  "eww" = import ./wayland/eww inputs;
  "swappy" = import ./swappy.nix inputs;
  "hyprland" = import ./wayland/hyprland inputs;
  # "base" = import ./profiles/base.nix inputs; # base profile
}
