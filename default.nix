with import <nixpkgs> {};

stdenv.mkDerivation rec {
  version = "0.1";
  name = "maki-${version}";
  src = fetchFromGitHub {
    owner = "rudsvar";
    repo = "maki";
    rev = "83e994fabdd7d6c3cc6e70d250d5469449754154";
    sha256 = "1p9vblgdxl177w0c70j3jdd9g37am1mj3ax4qydn5dwckxqaqx8s";
  };
  buildPhase = ''
    gcc maki.c -o maki
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp maki $out/bin
  '';
}
