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
  theme = args.theme or data.meta.theme or "stackoverflow";
  version = args.version or data.meta.version or "v0.0.1";
in
  stdenv.mkDerivation {
    inherit version;
    pname = "jsonresume-${theme}-${basename}.html";
    src = ../../../src;

    # Inputs needed by the builder
    nativeBuildInputs = [
      resumed
      root.themes.${theme}
    ];

    buildPhase = ''
      mkdir -p $out
      entry="${root.themes.${theme}}/lib/node_modules/jsonresume-theme-${theme}/index.js"
      if [[ ! -f "$entry" ]]; then
        entry="${root.themes.${theme}}/lib/node_modules/jsonresume-theme-${theme}/dist/index.js"

      fi
      resumed render ${super.json} \
        --theme $entry \
        --output $out/index.html
    '';

    meta = {
      homepage = "https://codeberg.org/Lehmanator/resume.nix";
      description = "JSONResume HTML output using theme: ${theme}";
      license = lib.licenses.agpl3Plus;
    };
  }
