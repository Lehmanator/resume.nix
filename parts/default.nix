{inputs, ...}: {
  imports = with inputs; [
    flake-parts.flakeModules.easyOverlay
    # pre-commit-hooks-nix.flakeModule

    ./data.nix
    ./packages.nix
    ./treefmt.nix

    ../shell
  ];
  debug = true;
  systems = [
    "aarch64-linux"
    "x86_64-linux"
    "riscv64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];
  flake = {
    lib = inputs.haumea.lib.load {
      src = ../lib;
      transformer = inputs.haumea.lib.transformers.liftDefault;
      inputs = {
        lib = inputs.nixpkgs.lib;
        # pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      };
    };
    # checks.themes = self.packages.themes-checks; #  # Check output to run checks for all themes
  };
}
