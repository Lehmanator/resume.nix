{ lib
, stdenv
, writeText
, src ? ./src/jsonresume.nix
, self, super, root
, ...
}:
let
  basename = builtins.head (lib.splitString "." (builtins.baseNameOf src));
in
writeText  "${basename}.json"  (lib.generators.toJSON {} ((import src) // {
  "$schema" = "https://raw.githubusercontent.com/jsonresume/resume-schema/v1.0.0/schema.json";
}))
