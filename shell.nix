with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "maki-env";
  buildInputs = [ (import ./maki.nix) ];
}
