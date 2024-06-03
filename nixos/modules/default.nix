inputs: {
  flake = import ./flake.nix inputs;
  fonts = import ./fonts.nix inputs;
  gaming = import ./gaming.nix inputs;
  nix = import ./nix.nix inputs;
  hyprland = import ./wayland/hyprland.nix inputs;
  greetd = import ./wayland/greetd.nix inputs;
  swappy = import ./wayland/swappy.nix inputs;
}
