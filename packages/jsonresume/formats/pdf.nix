{
  lib,
  stdenv,
  puppeteer-cli,
  super,
  root,
  src ? ./src/jsonresume/default.nix,
  ...
} @ args: let
  basename = builtins.head (lib.splitString "." (builtins.baseNameOf src));
  data = import src {inherit lib;};
  theme = args.theme or data.meta.theme or "stackoverflow";
in
  stdenv.mkDerivation {
    version = args.version or data.meta.version or "v0.0.1";
    pname = "jsonresume-${theme}-${basename}.pdf";
    src = super.html;

    meta = {
      homepage = "https://codeberg.org/Lehmanator/resume.nix";
      description = "JSONResume PDF output using theme: ${theme}";
      license = lib.licenses.agpl3Plus;
    };

    nativeBuildInputs = [
      puppeteer-cli
      root.themes.${theme}
      super.html
    ];

    buildPhase = ''
      XDG_CONFIG_HOME="$(mktemp -d)" \
      puppeteer print "${super.html}/index.html" $out
    '';
  }
