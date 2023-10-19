{inputs, ...}: {
  _file = ./default.nix;

  perSystem = {
    system,
    pkgs,
    lib,
    inputs',
    ...
  }: {
    packages = 
      {

      # instant repl with automatic flake loading
      repl = pkgs.callPackage ./repl {};
      };
};
}
