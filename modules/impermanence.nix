{
  config,
  lib,
  inputs,
  ...
}: {
  options.impermanence.enable = lib.mkEnableOption "impermanence";

  config = lib.mkIf config.impermanence.enable {
      hmModules = [inputs.impermanence.nixosModules.home-manager.impermanence];
      osModules = [inputs.impermanence.nixosModule];

      os = {
        environment.persistence."/persist" = {
          directories = ["/etc/nixos" "/etc/NetworkManager" "/var/log" "/var/lib" "/etc/nix" "/etc/ssh" "/var/db/sudo"];
          files = ["/etc/machine-id"];
        };

        users = {
          mutableUsers = false;
          users.neoney.initialHashedPassword = "$6$hAv60khFN/SnCt6r$LkoM5y7xGJPBGLr8DoNZB.mKJudpctUVZ75meQ6gTHBdp8q.dOmXgfTzZOw1.igi1gBc451Hc69TrUmqtFFqB.";
          users.root.hashedPasswordFile = "/persist/passwords/root";
          users.neoney.hashedPasswordFile = "/persist/passwords/neoney";
        };

        programs.fuse.userAllowOther = true;
      };

      hm = {
        home.homeDirectory = "/home/bruce";
        home.username = "bruce";

        home.persistence."/persist/home/bruce" = {
          directories =
            [
              "nixus"
              "Downloads"
              "code"
              "Documents"
              ".ssh"
              ".local/share/direnv"
              ".mozilla"
              {
                directory = ".local/share/Steam";
                method = "symlink";
              }
              {
                directory = ".steam";
                method = "symlink";
              }
              ".gnupg"
              ".config/WebCord"
              ".cache/starship"
              ".local/share/nheko"
              ".config/nheko"
              ".config/SchildiChat"
              ".local/share/keyrings"
              ".cache/nix-index"
              ".local/share/pnpm/store"
              ".bun"
            ];
          files = [
            ".cache/anyrun-ha-assist.sqlite3"
            ".local/share/fish/fish_history"
          ];
          allowOther = true;
        };
      };
    };
}
