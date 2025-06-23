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
    # TODO: Pass all attrs of pkgs
    allPackages = inputs.haumea.lib.load {
      src = ../packages/jsonresume;
      loader = inputs.haumea.lib.loaders.callPackage;
      transformer = inputs.haumea.lib.transformers.liftDefault;
      inputs = {
        variant = "sysadm";
        lib = pkgs.lib // top.config.flake.lib;
        src = ../src/jsonresume/default.nix;
        inherit
          (pkgs)
          callPackage
          chromium
          corepack
          coreutils
          buildNpmPackage
          chawan
          fetchFromGitea
          fetchFromGitHub
          fetchNpmDeps
          formats
          jq
          linkFarm
          nix-update-script
          nodejs
          npm-lockfile-fix
          pnpm_9
          python3
          python3Packages
          resumed
          puppeteer-cli
          symlinkJoin
          stdenv
          runCommand
          runCommandLocal
          writers
          writeText
          writeTextFile
          writeShellApplication
          writeShellScriptBin
          ;
      };
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
      jsonresume.formats
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
        # resume-cli = pkgs.callPackage ./packages/resume-cli {};
      };
  };
}
