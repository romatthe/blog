{ pkgs, stdenv, ... }:

stdenv.mkDerivation rec {
  pname = "romatthe-blog";
  version = "0.0.1";
  src = ./src;
  buildInputs = [ pkgs.zola ];
  buildPhase = ''
    zola build
  '';
  installPhase = ''
    cp -r public $out
  '';
}
