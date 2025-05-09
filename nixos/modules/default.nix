inputs: {
  cachix = import ./cachix inputs;
  flake = import ./flake.nix inputs;
  fonts = import ./fonts.nix inputs;
  gaming = import ./gaming.nix inputs;
  nix = import ./nix.nix inputs;
  greetd = import ./greetd.nix inputs;
  gnupg = import ./gnupg.nix inputs;
  # need to fix unfree setup first
  #brother-printer = import ./brother-printer.nix inputs;
}
