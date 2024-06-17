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
writeText  "${basename}.nix" (lib.generators.toPretty {} (import src))
