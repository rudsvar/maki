with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "maki-env";
  buildInputs = [ (import ./default.nix) ];
}
