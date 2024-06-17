{ src ? ./src/jsonresume.nix
, lib
, self, super, root
, formats
, ...
}:
let
  basename = builtins.head (lib.splitString "." (builtins.baseNameOf src));
in
  (formats.yaml {}).generate "${basename}.yaml" (import src)
