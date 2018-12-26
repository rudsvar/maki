with import <nixpkgs> {};

stdenv.mkDerivation rec {
  version = "0.1";
  name = "maki-${version}";
  src = fetchFromGitHub {
    owner = "rudsvar";
    repo = "maki";
    rev = "https://github.com/rudsvar/maki/archive/v0.1.tar.gz";
    sha256 = "1p9557kzvamxmbs5xqzbw4b4xsjqcw5l9m03ibkkmzb3f3v9yp9a";
  };
  buildPhase = ''
    gcc maki.c -o maki
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp maki $out/bin
  '';
}
