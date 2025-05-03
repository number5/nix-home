{ self, ... }:
{
  pkgs,
  ...
}:
{
  # Enable CUPS printing service
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      brlaser # Open source driver that works with your MFC-L8390CDW
      cups-filters # For color support
    ];
  };

  # Enable scanning functionality (SANE)
  hardware.sane = {
    enable = true;
    # Add both sane-airscan for network scanning via AirScan/eSCL protocol
    # and brscan5 for Brother-specific scanning features
    extraBackends = with pkgs; [
      sane-airscan
      brscan5
    ];
  };

  # Enable Avahi/mDNS for network printer discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Allow CUPS to discover network printers
  services.printing.browsing = true;
  services.printing.browsedConf = ''
    BrowseDNSSDSubTypes _cups,_print
    BrowseLocalProtocols all
    BrowseRemoteProtocols all
    CreateIPPPrinterQueues Yes
  '';

  # Open firewall ports for printing and scanning
  networking.firewall.allowedTCPPorts = [
    631
    9100
  ];
  networking.firewall.allowedUDPPorts = [ 631 ];

  # Add your user to scanner and lp groups
  users.users.bruce.extraGroups = [
    "scanner"
    "lp"
  ];
}
