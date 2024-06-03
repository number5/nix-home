inputs: {
  "home" = import ./home.nix inputs;
  "programs/nixpkgs" = import ./programs/nixpkgs inputs;
  "mutablerepos" = import ./mutablerepos.nix inputs;

  #  "i3" = import ./i3 inputs;
  "libvirt" = import ./libvirt.nix inputs;
  "apps" = import ./apps.nix inputs;
  # "polybar" = import ./polybar inputs;
  "dunst" = import ./dunst inputs;
  "anyrun" = import ./anyrun inputs;
  "eww" = import ./eww inputs;
}
