{
  inputs,
  config,
  lib,
  self',
  root,
  ...
}: {
  modules ? [],
  specialArgs ? {},
  system ? null,
}:
# Ensure a suitable `lib` is used
assert lib.assertMsg (specialArgs ? lib -> specialArgs.lib ? jsonresume) ''
  resume.nix requires a lib that includes some custom extensions, however the `lib` from `specialArgs` does not have a `jsonresume` attr.
  Remove `lib` from resume.nix's `specialArgs` or ensure you apply resume.nix's extensions to your `lib`.
  See https://docs.samlehman.dev/resume.nix/lib/index.html#using-a-custom-lib-with-resume-nix'';
assert lib.assertMsg (system != null -> lib.isString system) ''
  When `system` is supplied to `evalResume`, it must be a string.
  To define a more complex system, please use resume.nix's `nixpkgs.hostPlatform` option.'';
  lib.evalModules {
    modules =
      modules
      ++ [
        # ./jsonresume/modules/default.nix
        ../modules/jsonresume.nix
        # ../modules/goresume
        # ../modules/hackmyresume
        # ../modules/rendercv
        {
          _file = "<resume-flake>";
          # flake = lib.mkOptionDefault flake;
        }
        (lib.optionalAttrs (system != null) {
          _file = "evalResume";
          nixpkgs.hostPlatform = lib.mkOptionDefault {inherit system;};
        })
      ];
    specialArgs =
      {
        lib = lib.recursiveUpdate lib root;
        modulesPath = ../modules;
        pkgs =
          (inputs.nixpkgs.legacyPackages.${system} or inputs.nixpkgs.legacyPackages.x86_64-linux)
          // {
            jsonresume-packages = self'.packages;
          };
      }
      // specialArgs;
  }
