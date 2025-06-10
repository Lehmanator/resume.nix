{
  lib,
  stdenv,
  puppeteer-cli,
  self,
  super,
  root,
  src ? ./src/jsonresume/default.nix,
  ...
} @ args: let
  basename = builtins.head (lib.splitString "." (builtins.baseNameOf src));
  data = import src {inherit lib;};

  version = args.version or data.meta.version or "v0.0.1";
  theme = args.theme or data.meta.theme or "stackoverflow";

  output-data = lib.recursiveUpdate data {
    meta.theme = theme;
    meta.canonical = "https://raw.githubusercontent.com/Lehmanator/resume.nix/main/src/jsonresume/${basename}.nix";
    meta.version = version;
  };
in
  stdenv.mkDerivation {
    inherit version;
    pname = "jsonresume-${theme}-${basename}.pdf";
    allowSubstitutes = false;
    nativeBuildInputs = [
      puppeteer-cli
      root.themes.${theme}
      super.html
    ];
    src = root.themes.${theme};
    buildPhase = ''
      mkdir -p $out
      ${lib.getExe puppeteer-cli} print "${super.html}/index.html" $out/resume.pdf
    '';

    meta = {
      homepage = "https://codeberg.org/Lehmanator/resume.nix";
      description = "JSONResume PDF output using theme: ${theme}";
      license = lib.licenses.agpl3Plus;
    };
  }
