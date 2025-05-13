{
  lib,
  pkgs,
  ...
}:
{
  boot = {
    # use latest kernel
    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [
      "amdgpu.dcdebugmask=0x10"
      "resume_offset=104239104"

      # https://gitlab.freedesktop.org/drm/amd/-/issues/2539
      "acpi_mask_gpe=0x0e"
      "gpiolib_acpi.ignore_interrupt=AMDI0030:00@18"
    ];
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

    displayManager = {
      # defaultSession = "none+i3";
      sddm.autoNumlock = true;

      autoLogin = {
        enable = true;
        user = "bruce";
      };
    };

  };
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u32n.psf.gz";
    packages = [ pkgs.terminus_font ];
    useXkbConfig = true;
  };

  hardware = {
    bluetooth.enable = true;
    ledger.enable = true; # Allow ledger devices to connect.
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      git
      curl
      wget
      ripgrep
      openssh
      pciutils
      btrfs-progs
      rsync
    ];

    defaultPackages = lib.mkForce [ ];

    sessionVariables = {
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
      # for zsh config
      ZDOTDIR = "\${HOME}/.zsh";
    };

    # Disable gui prompt when git asks for a password.
    extraInit = ''
      unset -v SSH_ASKPASS
    '';
  };
}
