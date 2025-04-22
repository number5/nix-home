# .nixd.nix
# nix eval --json --file .nixd.nix > .nixd.json
{
  eval = {
    # Example target for writing a package.
    target = {
      args = [
        "-f"
        "default.nix"
      ];
      installable = "/flakeref#homeConfigurations.bruce";
    };
    # Force thunks
    depth = 5;
  };
  formatting.command = "treefmt";
  options = {
    enable = true;
    target = {
      args = [ ];
      # Example installable for flake-parts, nixos, and home-manager

      # flake-parts
      installable = "/flakeref#debug.options";

      # nixOS configuration
      #installable = "/flakeref#nixosConfigurations.<adrastea>.options";

      # home-manager configuration
      # installable = "/flakeref#homeConfigurations.<name>.options";
    };
  };
}
