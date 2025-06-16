{
  lib,
  stdenv,
  self,
  super,
  root,
  src ? ../../../src/jsonresume/default.nix,
  ...
} @ args: let
  basename = builtins.head (lib.splitString "." (builtins.baseNameOf src));
  data = import src {
    inherit lib;
  };
in
  stdenv.mkDerivation {
    pname = "jsonresume-all-${basename}";
    version = args.version or data.meta.version or "v0.0.1";
    src = super.html;

    buildPhase = ''
      mkdir $out
      echo 'Writing data files...'
      ln -s ${super.json} $out/${basename}.json
      ln -s ${super.nix}  $out/${basename}.nix
      ln -s ${super.toml} $out/${basename}.toml
      ln -s ${super.yaml} $out/${basename}.yaml

      echo 'Writing document files...'
      ln -s ${super.html}/index.html   $out/${basename}.html
      ln -s ${super.markdown}/index.md $out/${basename}.md
      ln -s ${super.pdf}               $out/${basename}.pdf
      echo 'Done.'
    '';

    meta = {
      description = "All JSONResume output formats in one directory.";
      homepage = "https://codeberg.org/Lehmanator/resume.nix";
      license = lib.licenses.agpl3Plus;
    };
  }
