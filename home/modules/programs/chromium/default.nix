{pkgs, ...}: {
  programs.chromium = {
    enable = true;
    commandLineArgs = ["--restore-last-session"];
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
    ];
  };
}
