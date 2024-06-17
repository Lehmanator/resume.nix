{inputs, ...}: {
  imports = [inputs.treefmt-nix.flakeModule];
  perSystem = {
    config,
    lib,
    pkgs,
    ...
  }: {
    treefmt = {
      flakeCheck = true;
      flakeFormatter = true;
      programs = {
        alejandra.enable = true;
        deadnix.enable = false;
        statix.enable = false;
        nixfmt.enable = false;
        nixpkgs-fmt.enable = false;
        formatjson5.enable = false;
        yamlfmt.enable = true;
      };
      projectRoot = inputs.self;
      projectRootFile = "flake.nix";
    };
  };
}
