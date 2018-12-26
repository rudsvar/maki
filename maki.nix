with import <nixpkgs> {};

stdenv.mkDerivation rec {
  version = "0.1";
  name = "maki-${version}";
  src = ./maki.c;
  unpackPhase = ''
    cp $src maki.c
  '';
  buildPhase = ''
    gcc maki.c -o maki
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp maki $out/bin
  '';
}
