{
  inputs,
  lib,
  ...
} @ top: {
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay

    # TODO: Move to ./devshells.nix
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
