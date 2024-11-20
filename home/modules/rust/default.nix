_: {pkgs, ...}: {
  home.packages = [
    pkgs.rustup
    pkgs.gcc
  ];
  home.sessionPath = ["$HOME/.cargo/bin"];
}
