{
  lib,
  stdenv,
  resumed,
  super,
  root,
  src ? ../../../src,
  ...
} @ args: let
  basename = builtins.head (lib.splitString "." (builtins.baseNameOf src));
  data = import src {
    inherit lib;
  };
in
  stdenv.mkDerivation {
    pname = "jsonresume-format-markdown-${basename}.md";
    version = args.version or data.meta.version or "v0.0.1";

    meta = {
      homepage = "https://codeberg.org/Lehmanator/resume.nix";
      description = "JSONResume Markdown output";
      license = lib.licenses.agpl3Plus;
    };

    src = ../../../src;

    nativeBuildInputs = [
      root.themes.hr-md
      resumed
    ];

    buildPhase = ''
      mkdir -p $out
      resumed render ${super.json} \
        --theme ${root.themes.hr-md}/lib/node_modules/jsonresume-theme-hr-md/index.js \
        --output $out/index.md
    '';
  }
