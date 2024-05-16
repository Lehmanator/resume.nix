{ inputs, ... }: {
  imports = [
    inputs.devshell.flakeModule
    inputs.flake-parts.flakeModules.easyOverlay
    #inputs.pre-commit-hooks-nix.flakeModule
  ];
  systems = [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
    "riscv64-linux"
  ];
}
