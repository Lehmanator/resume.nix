{
  description = "Personal resume built with jsonresume in Nix";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    hercules-ci-effects.url = "github:hercules-ci/hercules-ci-effects";
    mk-shell-bin.url = "github:rrbutani/nix-mk-shell-bin";
    pre-commit-hooks-nix.url = "github:cachix/pre-commit-hooks.nix";
    haumea.url = "github:nix-community/haumea";
    incl.url = "github:divnix/incl";
    #std.url = "github:divnix/std";
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix2container = {
      url = "github:nlewo/nix2container";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pyproject-nix = {
      url = "github:nix-community/pyproject.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rendercv = {
      url = "github:Lehmanator/rendercv";
      flake = false;
    };
    #"github:sinaatalay/rendercv";
  };
  outputs = {
    self,
    nixpkgs,
    flake-parts,
    haumea,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs self;} {
      imports = [./parts];
      debug = true;
      perSystem = {
        config,
        lib,
        pkgs,
        ...
      }: {
        formatter = pkgs.alejandra;
        #overlayAttrs = { inherit (packages) jsonresume-data; };
        apps = rec {
          # TODO: Live server
          # serve = { type = "app"; program = ""; };
          # TODO: Init resume, convert to nix
          init = {
            type = "app";
            program = pkgs.writeShellScriptBin "resume-init" ''
              if [[ $# -gt 0 ]]; then
                outfile=$1
              else
                outfile='./jsonresume.json'
              fi
              ${lib.getExe pkgs.resumed} init $outfile;
            '';
          };
          default = pdf;
          image = {
            type = "app";
            program = pkgs.writeShellScriptBin "resume-render-image" ''
              if [[ $# -gt 0 ]]; then
                outfile=$1
              else
                outfile='./jsonresume.png'
              fi
              ${lib.getExe pkgs.puppeteer-cli} screenshot \
                ${config.packages.jsonresume-format-html}/index.html \
                $outfile
                #--viewport 1920x1080 \
            '';
          };
          pdf = {
            type = "app";
            program = pkgs.writeShellScriptBin "resume-render-pdf" ''
              if [[ $# -gt 0 ]]; then
                outfile=$1
              else
                outfile='./jsonresume.pdf'
              fi
              ${lib.getExe pkgs.puppeteer-cli} print \
                ${config.packages.jsonresume-format-html}/index.html \
                $outfile
            '';
          };
          pdf2 = {
            type = "app";
            program = pkgs.writeShellScriptBin "resume-render-pdf" ''
              if [[ $# -gt 0 ]]; then
                outfile=$1
              else
                outfile='./jsonresume.pdf'
              fi
              ${lib.getExe pkgs.python3Packages.weasyprint} \
                --presentational-hints \
                --media-type screen \
                ${config.packages.jsonresume-format-html}/index.html \
                $outfile
            '';
          };
        };
        packages = let
          # TODO: Add attr `passthru.updaterScript` to make updating source revisions/hashes easier?
          # TODO: Add more themes
          jsonresume = haumea.lib.load {
            src = ./packages/jsonresume;
            loader = haumea.lib.loaders.callPackage;
            inputs = {
              lib = lib // builtins // self.lib;
              src = ./src/jsonresume.nix;
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
          jsonresume-themes = lib.mapAttrs' (n: v: lib.nameValuePair "jsonresume-theme-${n}" v) jsonresume.themes;
          jsonresume-formats = lib.mapAttrs' (n: v: lib.nameValuePair "jsonresume-format-${n}" v) jsonresume.formats;
          jsonresume-builders = {
            jsonresume-builder-pdf = pkgs.writeShellScriptBin "jsonresume-builder-pdf" ''
              if [[ $# -gt 0 ]]; then
                outfile=$1
              else
                outfile='./jsonresume.pdf'
              fi
              ${lib.getExe pkgs.puppeteer-cli} print \
                ${config.packages.jsonresume-format-html}/index.html \
                $outfile
            '';
          };
        in
          jsonresume-builders
          // jsonresume-themes
          // jsonresume-formats
          // {
            inherit (pkgs) resumed puppeteer-cli;
            #wkhtmltopdf pnmp-lock-export corepack_latest;
            inherit (pkgs.python3Packages) weasyprint;
            inherit (pkgs.nodePackages_latest) pnpm;
            # default = config.packages.resume;
            jsonresume-builder-pdf = pkgs.writeShellScript "resumed-render-pdf" ''
              ${lib.getExe pkgs.puppeteer-cli} print ${config.packages.jsonresume-format-html}/index.html ./jsonresume.pdf
            '';
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
              pkgs.callPackage ./packages/rendercv {
                inherit (inputs) rendercv;
                inherit (project.renderers) buildPythonPackage;
                python3 = pkgs.callPackage ./packages/rendercv/python.nix {};
              };
            #resume-cli = pkgs.callPackage ./packages/resume-cli {};

            # TODO: Wrap with webserver?

            #themes-checks = let
            #  builderAttrs = l.filterAttrs (n: _: l.hasPrefix "resume-" n) packages.${pkgs.system};
            #in pkgs.stdenv.mkDerivation {
            #  name = "themes-checks";
            #  src = ./template;
            #  buildPhase = ''
            #    cp resume.sample.json resume.json
            #  '' + (l.concatStringsSep "\n\n" (l.attrValues (l.mapAttrs (n: v: ''
            #    # Build using builder ${n}
            #    ${v}
            #    mv resume.html ${n}.html
            #  '') builderAttrs)));
            #  installPhase = ''
            #    mkdir $out
            #  '' + (l.concatStringsSep "\n\n" (l.attrValues
            #    (l.mapAttrs (n: _: "mv ${n}.html $out") builderAttrs)
            #  ));
            #};
          };
      };
      flake = {
        inherit inputs;
        lib = haumea.lib.load {
          src = ./lib;
          transformer = haumea.lib.transformers.liftDefault;
          inputs = {
            lib = inputs.nixpkgs.lib;
            # pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
            # inherit lib pkgs;
          };
        };

        # templates.default = { path = ./template; description = "Template to build jsonresume with nix"; };
        # checks.themes = self.packages.themes-checks; #  # Check output to run checks for all themes
      };
    };
}
