# Create a file named brother-mfcl8390cdw.nix
{ stdenv, lib, fetchurl, dpkg, autoPatchelfHook, cups, ghostscript }:

let
  version = "1.0.0-0";  # Use actual version from Brother's site
  
  lprDriverSrc = fetchurl {
    url = "https://download.brother.com/welcome/dlf103954/mfcl8390cdwlpr-1.0.0-0.i386.deb";
    sha256 = "1xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";  # Replace with actual hash
  };
  
  cupswrapperSrc = fetchurl {
    url = "https://download.brother.com/welcome/dlf103955/mfcl8390cdwcupswrapper-1.0.0-0.i386.deb";
    sha256 = "1xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";  # Replace with actual hash
  };
  
  scanKeySrc = fetchurl {
    url = "https://download.brother.com/welcome/dlf103956/brscan4-0.4.9-1.amd64.deb";
    sha256 = "1xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";  # Replace with actual hash
  };
  
in stdenv.mkDerivation {
  pname = "brother-mfcl8390cdw-drivers";
  inherit version;

  srcs = [ lprDriverSrc cupswrapperSrc scanKeySrc ];
  
  nativeBuildInputs = [ dpkg autoPatchelfHook ];
  buildInputs = [ cups ghostscript ];
  
  unpackPhase = ''
    for src in $srcs; do
      dpkg-deb -x $src source-${basename $src}
    done
    sourceRoot=source
  '';

  installPhase = ''
    mkdir -p $out/lib/cups/filter/
    mkdir -p $out/share/cups/model/Brother/
    mkdir -p $out/opt/brother/
    
    # Copy driver files
    cp -r source-*/opt/brother/* $out/opt/brother/
    
    # Copy CUPS filters and PPDs
    cp -v source-*/usr/lib/cups/filter/* $out/lib/cups/filter/ || true
    cp -v source-*/usr/share/cups/model/Brother/* $out/share/cups/model/Brother/ || true
    cp -v source-*/usr/share/ppd/Brother/* $out/share/cups/model/Brother/ || true
    
    # Make filters executable
    chmod +x $out/lib/cups/filter/* || true
  '';

  meta = with lib; {
    description = "Brother MFC-L8390CDW printer drivers";
    license = licenses.unfree;
    platforms = platforms.linux;
  };
}
