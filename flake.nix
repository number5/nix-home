{
  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    parts.url = "github:hercules-ci/flake-parts";
    # nixos-flake.url = "github:srid/nixos-flake";

    # The following is required to make flake-parts work.
    nixpkgs.follows = "nixpkgs-unstable";
    unstable.follows = "nixpkgs-unstable";

    programsdb.url = "github:wamserma/flake-programs-sqlite";
    programsdb.inputs.nixpkgs.follows = "unstable";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nixd.url = "github:nix-community/nixd";
    nuenv.url = "github:DeterminateSystems/nuenv";

    # Minecraft
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nix-minecraft.inputs.nixpkgs.follows = "nixpkgs";

    # hyprland

    hyprland.url = "github:hyprwm/hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";

    hyprpaper.url = "github:hyprwm/hyprpaper";
    hyprpicker.url = "github:hyprwm/hyprpicker";

    hyprcontrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    shadower.url = "github:n3oney/shadower";

    # eww
    rust-overlay.url = "github:oxalica/rust-overlay";
    eww = {
      url = "github:ralismark/eww/tray-3";
      # url = "github:elkowar/eww";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };

    # anyrun
    anyrun.url = "github:kirottu/anyrun";
    anyrun-ha-assist.url = "github:n3oney/anyrun-ha-assist";
    anyrun-nixos-options.url = "github:n3oney/anyrun-nixos-options";


    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.flake-utils.follows = "fu";
    };
    # impermanence.url = "github:nix-community/impermanence";

    dotzsh.url = "github:number5/dotzsh";
    dotzsh.flake = false;
  };

  outputs = inputs:
    inputs.parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-darwin"];

      imports = [
        # ./home/profiles
        ./hosts
        # ./lib
        ./modules
        ./packages
        ./pre-commit-hooks.nix
      ];

      perSystem = {
        config,
        pkgs,
        ...
      }: {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.alejandra
            pkgs.git
            config.packages.repl
          ];
          name = "dots";
          DIRENV_LOG_FORMAT = "";
        };

        formatter = pkgs.alejandra;
      };
    };
}
