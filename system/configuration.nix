{ pkgs, lib, system, username, hostName, stateVersion, ... }:

{
  ${hostName} = lib.nixosSystem {
    inherit system;
    modules = [{
      imports = [ ./hardware-configuration.nix ];

      # Bootloader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.efi.efiSysMountPoint = "/boot/";

      networking = {
        inherit hostName;
        networkmanager.enable = true;
      };

      # Set your time zone.
      time.timeZone = "Australia/Melbourne";

      # Select internationalisation properties.
      i18n.defaultLocale = "en_US.utf8";

      services = {
        blueman.enable = true;
        getty.autologinUser = username;

        dbus = {
          enable = true;
          packages = [ pkgs.dconf ];
        };

        xserver = {
          enable = true;
          layout = "us";
          xkbOptions = "caps:swapescape"; # Swap caps-lock with escape.
          videoDrivers = [ "amdgpu" ];
          libinput = {
            enable = true;
            mouse = {
              accelProfile = "flat"; # Disable acceleration.
              middleEmulation = false; # Disable emulating middle click using left + right clicks;
            };
          };

          displayManager = {
            defaultSession = "none+i3";
            sddm.autoNumlock = true;

            autoLogin = {
              enable = true;
              user = username;
            };
          };

          windowManager.i3 = {
            enable = true;
            package = pkgs.i3-gaps;
          };
        };
      };

      console.useXkbConfig = true;

      hardware = {
        pulseaudio.enable = true;
        bluetooth.enable = true;
        ledger.enable = true; # Allow ledger devices to connect.
      };

      users.users.${username} = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" "audio" ];
        packages = with pkgs; [ ];
      };

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      environment = {
        # List packages installed in system profile. To search, run:
        # $ nix search wget
        systemPackages = with pkgs; [ git ];

        # Disable gui prompt when git asks for a password.
        extraInit = ''
          unset -v SSH_ASKPASS
        '';
      };

      fonts.fonts = with pkgs; [ nerdfonts ];

      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];

      nix = {
        package = pkgs.nixFlakes;
        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 7d";
        };
        settings = {
          auto-optimise-store = true;
          experimental-features = [ "nix-command" "flakes" ];
          trusted-public-keys = [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
          ];
          substituters = [
            "https://cache.nixos.org"
            "https://cache.iog.io"
          ];
        };
      };

      system.stateVersion = stateVersion;
    }];
  };
}
