with import <nixpkgs> {};

stdenv.mkDerivation rec {
  version = "0.1";
  name = "maki-${version}";
  src = fetchFromGithub {
    owner = "rudsvar";
    repo = "maki";
    rev = "";
    sha256 = "1qas084gc4s9cb2jbwi2s1h4hk7m92xmrsb596sd14h0i44dai02";
  };
  unpackPhase = "ls";
}
