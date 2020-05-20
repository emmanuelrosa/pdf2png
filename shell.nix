{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { stdenv, makeWrapper, lib, imagemagick, ghostscript }:
      stdenv.mkDerivation {
        pname = "pdf2png";
        version = "0.1.0.0";
        src = ./.;

        nativeBuildInputs = [ makeWrapper ];

        installPhase = ''
          install -D pdf2png.sh $out/bin/pdf2png
        '';

        postFixup = ''
          wrapProgram $out/bin/pdf2png --prefix PATH : ${lib.makeBinPath [ imagemagick ghostscript]}
        '';

        meta = {
          homepage = "https://github.com/emmanuelrosa/pdf2png";
          description = "A script for converting a PDF into PNGs.";
          license = stdenv.lib.licenses.mit;
        };
      };
in
  with pkgs; pkgs.callPackage f { inherit makeWrapper; }
