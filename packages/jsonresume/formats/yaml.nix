{
  lib,
  formats,
  src ? ./src/jsonresume/default.nix,
  self,
  super,
  root,
  ...
} @ args: let
  basename = builtins.head (lib.splitString "." (builtins.baseNameOf src));
  data = import src {
    inherit lib;
  };
  theme = args.theme or data.meta.theme or "stackoverflow";
  version = args.version or data.meta.version or "v0.0.1";
in
  ((formats.yaml {}).generate "jsonresume-${theme}-${basename}.yaml" (lib.recursiveUpdate data {
    # "$schema" = "https://raw.githubusercontent.com/jsonresume/resume-schema/v1.0.0/schema.json";
    meta.canonical = "https://raw.githubusercontent.com/Lehmanator/resume.nix/main/src/jsonresume/${basename}.nix";
    meta.theme = theme;
    meta.version = version;
  }))
  // {
    version = lib.removePrefix "v" version;
    meta = {
      description = "JSONResume YAML input data for variant: ${basename}";
      homepage = "https://codeberg.org/Lehmanator/resume.nix";
      mainProgram = self.outPath;
      license = lib.licenses.agpl3Plus;
    };
  }
