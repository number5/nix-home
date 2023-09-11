
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/";
    };

    # use latest kernel
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelParams = ["amd_pstate=active"];
  };

  networking = {
    hostName = "chestnut";
    networkmanager.enable = true;
  };

  services = {
    blueman.enable = true;
    getty.autologinUser = "bruce";

    # gvfs for easy workflows with external drives
    gvfs.enable = true;

    upower.enable = true;

    logind.extraConfig = ''
      LidSwitchIgnoreInhibited=no
      HandlePowerKey=ignore
    '';

    fprintd.enable = true;

    journald.extraConfig = "SystemMaxUse=1G";

    xserver = {
      enable = true;
      layout = "us";
      xkbOptions = "caps:escape"; # Caps-lock is the new Escape.
      videoDrivers = ["amdgpu"];
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
          user = "bruce";
        };
      };

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3;
      };
    };
  };

  console.useXkbConfig = true;

  hardware = {
    bluetooth.enable = true;
    ledger.enable = true; # Allow ledger devices to connect.
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [git curl wget ripgrep openssh];

    sessionVariables = rec {
      XDG_CACHE_HOME = "\${HOME}/.cache";
      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_BIN_HOME = "\${HOME}/.local/bin";
      XDG_DATA_HOME = "\${HOME}/.local/share";
      # Steam needs this to find Proton-GE
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      # note: this doesn't replace PATH, it just adds this to it
      PATH = [
        "\${XDG_BIN_HOME}"
      ];
      GIT_SSH = "${pkgs.openssh}/bin/ssh";
    };

    # Disable gui prompt when git asks for a password.
    extraInit = ''
      unset -v SSH_ASKPASS
    '';
  };
}