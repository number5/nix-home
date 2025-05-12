inputs: {
  "home" = import ./home.nix inputs;
  "zsh" = import ./zsh.nix inputs;
  "wezterm" = import ./wezterm inputs;
  "nixpkgs" = import ./nixpkgs inputs;
  "mutablerepos" = import ./mutablerepos.nix inputs;

  #  "i3" = import ./i3 inputs;
  # "polybar" = import ./polybar inputs;
  "hyprland" = import ./hyprland inputs;
  "libvirt" = import ./libvirt.nix inputs;
  "apps" = import ./apps.nix inputs;
  "dunst" = import ./dunst inputs;
  "eww" = import ./eww inputs;
  "foot" = import ./foot inputs;

  "dotfiles" = import ./dotfiles inputs;
  "neovim" = import ./neovim inputs;
  "pamixer" = import ./pamixer.nix inputs;
  # "chromium" = import ./chromium inputs;
  "direnv" = import ./direnv inputs;
  "rust" = import ./languages/rust.nix inputs;
}
