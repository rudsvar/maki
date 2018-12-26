with import <nixpkgs> {};

stdenv.mkDerivation rec {
  version = "0.1";
  name = "maki-${version}";
  src = fetchFromGitHub {
    owner = "rudsvar";
    repo = "maki";
    rev = "613af954cb0679aeb0460a33a1a18e4cc5a0f184";
    sha256 = "000y4jd90qvpri71rkzmc8whbahb8161qjs907rmankwsb2zj1jm";
  };
  buildPhase = ''
    gcc maki.c -o maki
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp maki $out/bin
  '';
}
