{ pkgs, lib, system, username, hostName, stateVersion, ... }:

{
  ${hostName} = lib.nixosSystem {
    inherit system;
    modules = [{
      imports = [ 
        # Or modules from other flakes (such as nixos-hardware):
        inputs.hardware.nixosModules.common-cpu-amd
        inputs.hardware.nixosModules.common-gpu-amd

        ./hardware-configuration.nix 
        ./hidpi.nix
        ./misc.nix
      ];

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
        getty.autologinUser = "${username}";

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
              user = "${username}";
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

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      environment = {
        # List packages installed in system profile. To search, run:
        # $ nix search wget
        systemPackages = with pkgs; [ git curl wget ripgrep ];

      	sessionVariables = rec {
          XDG_CACHE_HOME  = "\${HOME}/.cache";
          XDG_CONFIG_HOME = "\${HOME}/.config";
          XDG_BIN_HOME    = "\${HOME}/.local/bin";
          XDG_DATA_HOME   = "\${HOME}/.local/share";
          # Steam needs this to find Proton-GE
          STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
          # note: this doesn't replace PATH, it just adds this to it
          PATH = [ 
            "\${XDG_BIN_HOME}"
          ];
        }
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

      services.openssh = {
        enable = true;
        # Forbid root login through SSH.
        permitRootLogin = "no";
        # Use keys only. Remove if you want to SSH using password (not recommended)
        passwordAuthentication = false;
      };

      system.stateVersion = stateVersion;
    }];
  };
}
