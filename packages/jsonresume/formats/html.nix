{
  lib,
  stdenv,
  resumed,
  self,
  super,
  root,
  src,
  ...
}: let
  jsonresume-theme-all = root.themes.all;
  data = import src;
  inherit (data.meta) theme version;
in
  stdenv.mkDerivation {
    inherit (data.meta) version;
    pname = "jsonresume-html";
    src = ../../../src;

    # propagatedBuildInputs = [super.json];
    buildInputs = [jsonresume-theme-all resumed];
    buildPhase = ''
      mkdir -p $out
      ${lib.getExe resumed} render ${super.json} \
        --theme ${jsonresume-theme-all}/lib/node_modules/jsonresume-theme-${theme}/index.js \
        --output $out/index.html
    '';
  }
