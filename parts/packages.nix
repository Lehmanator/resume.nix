{
  inputs,
  self,
  lib,
  ...
}: {
  perSystem = {
    self',
    pkgs,
    ...
  }: {
    # overlayAttrs = { inherit (self'.packages) jsonresume-data; };

    # TODO: Add attr `passthru.updaterScript` to make updating source revisions/hashes easier?
    packages = let
      jsonresume = inputs.haumea.lib.load {
        src = ../packages/jsonresume;
        loader = inputs.haumea.lib.loaders.callPackage;
        inputs = {
          lib = lib // builtins // self.lib;
          src = ../src/jsonresume.nix;
          inherit
            (pkgs)
            buildNpmPackage
            fetchFromGitHub
            formats
            python3
            resumed
            puppeteer-cli
            symlinkJoin
            stdenv
            runCommand
            runCommandLocal
            writeText
            writeTextFile
            ;
        };
      };
      # TODO: Add more themes
      jsonresume-themes = lib.mapAttrs' (n: v: lib.nameValuePair "jsonresume-theme-${n}" v) jsonresume.themes;
      jsonresume-formats = lib.mapAttrs' (n: v: lib.nameValuePair "jsonresume-format-${n}" v) jsonresume.formats;
      jsonresume-builders = {
        jsonresume-builder-pdf = pkgs.writeShellScriptBin "jsonresume-builder-pdf" ''
          outfile="''${1:-./jsonresume.pdf}"
          ${lib.getExe pkgs.puppeteer-cli} print \
            ${self'.packages.jsonresume-format-html}/index.html \
            $outfile
        '';
      };
    in
      {
        inherit (pkgs) resumed puppeteer-cli;
        # default = self'.packages.resume;
        jsonresume-builder-pdf = pkgs.writeShellScript "resumed-render-pdf" ''
          ${lib.getExe pkgs.puppeteer-cli} print ${self'.packages.jsonresume-format-html}/index.html ./jsonresume.pdf
        '';
        default = self'.packages.jsonresume-format-html;

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

        # TODO: Wrap with webserver?

        # themes-checks = let
        #   builderAttrs = l.filterAttrs (n: _: l.hasPrefix "resume-" n) packages.${pkgs.system};
        # in pkgs.stdenv.mkDerivation {
        #   name = "themes-checks";
        #   src = ./template;
        #   buildPhase = ''
        #     cp resume.sample.json resume.json
        #   '' + (l.concatStringsSep "\n\n" (l.attrValues (l.mapAttrs (n: v: ''
        #     # Build using builder ${n}
        #     ${v}
        #     mv resume.html ${n}.html
        #   '') builderAttrs)));
        #   installPhase = ''
        #     mkdir $out
        #   '' + (l.concatStringsSep "\n\n" (l.attrValues
        #     (l.mapAttrs (n: _: "mv ${n}.html $out") builderAttrs)
        #   ));
        # };
      }
      // jsonresume-builders
      // jsonresume-themes
      // jsonresume-formats;

    apps = rec {
      default = pdf;
      # TODO: Live server
      # serve = { type = "app"; program = ""; };
      init = {
        type = "app";
        meta.description = "Initialize a resume from a template.";
        # TODO: Init resume, convert to nix
        program = pkgs.writeShellScriptBin "resume-init" ''
          outfile="''${1:-./jsonresume.json}"
          ${lib.getExe pkgs.resumed} init $outfile;
        '';
      };
      image = {
        type = "app";
        program = pkgs.writeShellScriptBin "resume-render-image" ''
          outfile="''${1:-./jsonresume.png}"
          ${lib.getExe pkgs.puppeteer-cli} screenshot \
            ${self'.packages.jsonresume-format-html}/index.html \
            $outfile
            # --viewport 1920x1080 \
        '';
      };
      pdf = {
        type = "app";
        program = pkgs.writeShellScriptBin "resume-render-pdf" ''
          outfile="''${1:-./jsonresume.pdf}"
          ${lib.getExe pkgs.puppeteer-cli} print \
            ${self'.packages.jsonresume-format-html}/index.html \
            $outfile
        '';
      };
      pdf2 = {
        type = "app";
        program = pkgs.writeShellScriptBin "resume-render-pdf" ''
          outfile="''${1:-./jsonresume.pdf}"
          if [[ $# -gt 0 ]]; then
            outfile=$1
          else
            outfile='./jsonresume.pdf'
          fi
          ${lib.getExe pkgs.python3Packages.weasyprint} \
            --presentational-hints \
            --media-type screen \
            ${self'.packages.jsonresume-format-html}/index.html \
            $outfile
        '';
      };
    };
  };
}
