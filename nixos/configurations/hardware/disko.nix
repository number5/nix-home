# nix --extra-experimental-features 'flakes nix-command' shell github:nix-community/disko
# sudo disko --debug --dry-run --mode disko ./disko.nix
{
  # disko.enableConfig = false;
  disko.devices = {
    disk = {
      nvme1n1 = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-SHPP41-2000GM_ADC7N40201110734J";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Override existing partition
                # Subvolumes must set a mountpoint in order to be mounted,
                # unless their parent is mounted
                subvolumes = {
                  "@" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "@games" = {
                    mountpoint = "/Games";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };

                  "@virtualMachines" = {
                    mountpoint = "/VMs";
                    mountOptions = [
                      "nodatacow"
                      "noatime"
                    ];
                  };
                  "@logs" = {
                    mountpoint = "/var/log";
                    mountOptions = [
                      "nodatacow"
                      "noatime"
                    ];
                  };

                  "@snapshots" = { };
                  "@swap" = {
                    mountpoint = "/.swapvol";
                    swap.swapfile.size = "16G";
                  };
                };

                mountpoint = "/partition-root";
                swap = {
                  swapfile = {
                    size = "16G";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
