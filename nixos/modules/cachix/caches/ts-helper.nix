{
  config,
  lib,
  ...
}:
{
  nix.settings = {
    substituters = [
      "https://ts-helper.cachix.org"
    ];
    trusted-public-keys = [
      "ts-helper.cachix.org-1:l9XtzxPqlR/lKsKpTS+DcCn4cCuYiUSgGzIsLF3vz9Q="
    ];
  };
}
