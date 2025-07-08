{
  inputs,
  lib,
  ...
} @ top: {
  perSystem = {
    config,
    pkgs,
    ...
  }: let
    inherit (inputs.haumea.lib) load loaders transformers;

    allPackages = load {
      src = ../packages/jsonresume;
      loader = loaders.callPackage;
      transformer = transformers.liftDefault;
      inputs = (builtins.removeAttrs pkgs ["root" "self" "super"]) // {src = ../src/jsonresume/default.nix;};
    };

    jsonresume = {
      themes = lib.mapAttrs' (n: v: lib.nameValuePair "jsonresume-theme-${n}" v) allPackages.themes or {};
      formats = lib.mapAttrs' (n: v: lib.nameValuePair "jsonresume-format-${n}" v) allPackages.formats or {};
      scripts = lib.mapAttrs' (n: v: lib.nameValuePair "jsonresume-script-${n}" v) allPackages.scripts or {};
    };
  in {
    # TODO: Add attr `passthru.updaterScript` to make updating source revisions/hashes easier?
    # TODO: Add more themes
    # TODO: Collection of all HTML pages for each theme.
    # TODO: Collection of all JSON data for each theme.
    # TODO: Collection of all JSON data for each theme.
    packages =
      (builtins.removeAttrs allPackages ["formats" "scripts" "themes"])
      // jsonresume.formats
      // jsonresume.scripts
      // jsonresume.themes
      // {
        inherit (pkgs) resumed puppeteer-cli;
        default = config.packages.jsonresume-format-html;
        rendercv = let
          src-cfg = inputs.rendercv.outPath + "/pyproject.toml";
          cfg-orig = lib.importTOML src-cfg;
          cfg-over = {build-system.requires = ["hatchling>=1.21.1"];};
          project = inputs.pyproject-nix.lib.project.loadPyproject {
            pyproject = lib.recursiveUpdate cfg-orig cfg-over;
            projectRoot = inputs.rendercv.outPath;
          };
        in
          pkgs.callPackage ../packages/rendercv {
            inherit (inputs) rendercv;
            inherit (project.renderers) buildPythonPackage;
            python3 = pkgs.callPackage ../packages/rendercv/python.nix {};
          };
      };
  };
}
