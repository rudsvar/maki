with import <nixpkgs> {};

stdenv.mkDerivation rec {
  version = "0.1";
  name = "maki-${version}";
  src = fetchFromGitHub {
    owner = "rudsvar";
    repo = "maki";
    rev = "83e994fabdd7d6c3cc6e70d250d5469449754154";
    sha256 = "1gxm0k16q1lksbvgzzmcl1g6xm3dyb2n89cgpjci9jpr07igd6s0";
  };
  buildPhase = ''
    gcc maki.c -o maki
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp maki $out/bin
  '';
}
