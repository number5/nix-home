inputs: {
  cachix = import ./cachix inputs;
  flake-setup = import ./flake-setup.nix inputs;
  fonts = import ./fonts.nix inputs;
  gaming = import ./gaming.nix inputs;
  nix = import ./nix.nix inputs;
  greetd = import ./greetd.nix inputs;
  gnupg = import ./gnupg.nix inputs;
  keychron = import ./keychron.nix inputs;
  # need to fix unfree setup first
  #brother-printer = import ./brother-printer.nix inputs;
}
