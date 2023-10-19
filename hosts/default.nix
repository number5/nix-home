{
  inputs,
  sharedModules,
  homeImports,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
  in {
    chestnut = nixosSystem {
      modules =
        [
          ./chestnut
          ../modules/bluetooth.nix
          ../modules/greetd.nix
          ../modules/desktop.nix
          ../modules/gamemode.nix
          ../modules/lanzaboote.nix
          ../modules/power-switcher.nix
          {home-manager.users.bruce.imports = homeImports."bruce@chestnut";}
        ]
        ++ sharedModules;
    };

  };
}
