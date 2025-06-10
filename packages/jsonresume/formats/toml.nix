{
  src ? ./src/jsonresume/default.nix,
  lib,
  self,
  super,
  root,
  formats,
  ...
} @ args: let
  basename = builtins.head (lib.splitString "." (builtins.baseNameOf src));

  data = import src {
    inherit lib;
  };

  theme = args.theme or data.meta.theme or "stackoverflow";
  version = args.version or data.meta.version or "v0.0.1";

  output-data = lib.recursiveUpdate data {
    "$schema" = "https://raw.githubusercontent.com/jsonresume/resume-schema/v1.0.0/schema.json";
    meta.canonical = "https://raw.githubusercontent.com/Lehmanator/resume.nix/main/src/jsonresume/${basename}.nix";
    meta.theme = theme;
    meta.version = version;
  };
in
  (formats.toml {}).generate "jsonresume-${theme}-${basename}.toml" output-data
