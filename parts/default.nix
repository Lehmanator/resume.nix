{
  inputs,
  self,
  config,
  lib,
  ...
} @ top: {
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
    # inputs.pre-commit-hooks-nix.flakeModule
    ../shell
    ./apps.nix
    ./lib.nix
    ./packages.nix
  ];
  systems = [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
    "riscv64-linux"
  ];

  perSystem = {pkgs, ...}: {
    formatter = pkgs.alejandra;
  };
}
