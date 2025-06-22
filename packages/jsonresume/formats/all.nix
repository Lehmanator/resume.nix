{
  lib,
  linkFarm,
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
  (linkFarm "jsonresume-all-${basename}" [
    {
      name = "${basename}.nix";
      path = super.nix;
    }
    {
      name = "${basename}.json";
      path = super.json;
    }
    {
      name = "${basename}.toml";
      path = super.toml;
    }
    {
      name = "${basename}.yaml";
      path = super.yaml;
    }

    {
      name = "${basename}.html";
      path = "${super.html.outPath}/index.html";
    }
    {
      name = "${basename}.pdf";
      path = super.pdf;
    }
  ])
  // {
    version = args.version or data.meta.version or "v0.0.1";
    meta = {
      description = "JSONResume outputs: All formats for variant: ${basename}.";
      homepage = "https://codeberg.org/Lehmanator/resume.nix";
      license = lib.licenses.agpl3Plus;
    };
  }
