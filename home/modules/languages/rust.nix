{fenix, ...}: {pkgs, ...}: {

  home.packages =  [
      fenix.packages.${pkgs.system}.complete.toolchain
      fenix.packages.${pkgs.system}.rust-analyzer
  ];
}
