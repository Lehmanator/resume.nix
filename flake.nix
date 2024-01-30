{
  description = "Personal resume built with jsonresume in Nix";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    hercules-ci-effects.url = "github:hercules-ci/hercules-ci-effects";
    devenv.url = "github:cachix/devenv";
    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";
    pre-commit-hooks-nix.url = "github:cachix/pre-commit-hooks.nix";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = {
    self,
    nixpkgs,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.devenv.flakeModule
        #inputs.devshell.flakeModule
        inputs.flake-parts.flakeModules.easyOverlay
        inputs.hercules-ci-effects.flakeModule
        #inputs.pre-commit-hooks-nix.flakeModule
        inputs.treefmt-nix.flakeModule
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
        "riscv64-linux"
      ];
      debug = true;
      hercules-ci = {
        github-pages = {
          branch = "main";
          check.enable = true;
          pushJob = "default";
        };
        github-releases.files = {
          label = "resume";
          path = self.packages.default + "/resume.json";
        };
      };
      perSystem = {
        config,
        lib,
        pkgs,
        ...
      }: {
        devenv.shells.default = {
          name = "resume.nix";
          certificates = ["resume.samlehman.dev"];
          #devcontainer = { enable= true; settings= {}; };
          difftastic.enable = true;
          enterShell = ''
            echo "Welcome to resume.nix!"
          '';
          env = {};
          hosts = {"resume.samlehman.dev" = "127.0.0.1";};
          languages = {
            javascript.enable = true;
            nix.enable = true;
            #texlive = {enable=true; packages=["collection-basic"]; base=pkgs.texlive;};
          };
          packages = with config.packages; [
            pkgs.nix-direnv
            pkgs.resumed
            pkgs.puppeteer-cli
            default
            jsonresume-theme-elegant
            jsonresume-theme-full
            jsonresume-theme-fullmoon
            jsonresume-theme-kendall
            jsonresume-theme-macchiato
            jsonresume-theme-stackoverflow
            config.treefmt.build.wrapper
            #config.treefmt.build.programs
          ];
          #pre-commit = {}; #https://github.com/cachix/pre-commit-hooks.nix
          #process = {
          #  after = "";
          #  before = "";
          #  implementation = "honcho"; # honcho|overmind|process-compose|hivemind
          #  process-compose = {port=9999; tui=true; version="0.5"; };
          #};
          starship = {
            enable = true;
            #config = {enable = true; path = "${config.env.DEVENV_ROOT}/starship.toml";};
          };
        };
        hercules-ci.github-pages = {
          settings = {contents = config.packages.default;};
        };
        #_modules.args.pkgs =
        overlayAttrs = {inherit (config.packages) resume-json;};
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
          projectRoot = self;
          projectRootFile = "flake.nix";
        };
        packages = let
          version = "0.1.0";
          builder = theme: let
            htmlPkgName = "jsonresume-html-${theme}";
            htmlPkg = config.packages.${htmlPkgName};
            themePkgName = "jsonresume-theme-${theme}";
            themePkg = config.packages.${themePkgName};
          in {
            html = pkgs.stdenv.mkDerivation rec {
              inherit version;
              pname = htmlPkgName; # "resume-${theme}-html";
              allowSubstitutes = false;
              nativeBuildInputs = [pkgs.resumed themePkg];
              propagatedBuildInputs = [config.packages.resume-src themePkg];
              src = ./src;
              buildPhase = ''
                mkdir -p $out
                cp ${config.packages.resume-src}/resume.json .
                cp ${src}/*.{jpeg,jpg,webp,gif,png,ico,woff,ttf,otf,js} .
                cp ${src}/*.{jpeg,jpg,webp,gif,png,ico,woff,ttf,otf,js} $out
                ${pkgs.resumed}/bin/resumed render \
                --theme ${themePkg}/lib/node_modules/${themePkgName}/index.js \
                --output $out/index.html
                chmod +x $out/*.{html,js}
              '';
            };
            pdf = pkgs.stdenv.mkDerivation {
              inherit version;
              pname = "jsonresume-pdf-${theme}";
              allowSubstitutes = false;
              nativeBuildInputs = [pkgs.puppeteer-cli htmlPkg];
              src = htmlPkg;
              buildPhase = ''
                mkdir -p $out
                ${pkgs.puppeteer-cli}/bin/puppeteer print ${htmlPkg}/index.html $out/resume.pdf
              '';
            };
          };
        in {
          inherit (pkgs) resumed puppeteer-cli;
          #wkhtmltopdf pnmp-lock-export corepack_latest ;
          inherit (pkgs.python311Packages) weasyprint;
          inherit (pkgs.nodePackages_latest) pnpm;

          default = config.packages.resume;
          resume = pkgs.symlinkJoin {
            name = "resume";
            paths = [
              config.packages.jsonresume-html-fullmoon
              config.packages.jsonresume-pdf-fullmoon
            ];
          };

          resume-src = pkgs.stdenv.mkDerivation rec {
            inherit version;
            pname = "resume-json";
            allowSubstitutes = false;
            src = ./src;
            buildPhase = ''
              cat << "EOF" > resume.json
              ${builtins.toJSON (import "${src}/resume.nix")}
              EOF
            '';
            installPhase = ''
              mkdir -p $out
              cp $src/* $out
              cp resume.json $out
            '';
          };

          # TODO: Genericize
          jsonresume-html-full = (builder "full").html;
          jsonresume-html-fullmoon = (builder "fullmoon").html;
          jsonresume-html-elegant = (builder "elegant").html;
          jsonresume-html-kendall = (builder "kendall").html;
          jsonresume-html-macchiato = (builder "macchiato").html;
          jsonresume-html-stackoverflow = (builder "stackoverflow").html;

          jsonresume-pdf-full = (builder "full").pdf;
          jsonresume-pdf-fullmoon = (builder "fullmoon").pdf;
          jsonresume-pdf-elegant = (builder "elegant").pdf;
          jsonresume-pdf-kendall = (builder "kendall").pdf;
          jsonresume-pdf-macchiato = (builder "macchiato").pdf;
          jsonresume-pdf-stackoverflow = (builder "stackoverflow").pdf;

          # TODO: Add more themes
          # TODO: Add attr `passthru.updaterScript` to make updating source revisions/hashes easier?
          jsonresume-theme-elegant =
            pkgs.callPackage ./packages/jsonresume-themes/elegant {};
          jsonresume-theme-full =
            pkgs.callPackage ./packages/jsonresume-themes/full {};
          jsonresume-theme-fullmoon =
            pkgs.callPackage ./packages/jsonresume-themes/fullmoon {};
          jsonresume-theme-kendall =
            pkgs.callPackage ./packages/jsonresume-themes/kendall {};
          jsonresume-theme-macchiato =
            pkgs.callPackage ./packages/jsonresume-themes/macchiato {};
          jsonresume-theme-stackoverflow =
            pkgs.callPackage ./packages/jsonresume-themes/stackoverflow {};

          # TODO: Scoped packages: `jsonresume-themes.<themeName>`
          #jsonresume-themes = lib.makeScope pkgs.newScope (selfScope: with selfScope; {
          #  elegant = pkgs.callPackage ./packages/jsonresume-themes/elegant {};
          #  full = pkgs.callPackage ./packages/jsonresume-themes/full {};
          #  fullmoon = pkgs.callPackage ./packages/jsonresume-themes/fullmoon {};
          #});

          #jsonresume-all = pkgs.symlinkJoin {
          #  name = "jsonresume-themes";
          #  paths =
          #    [config.packages.resume-json]
          #    ++ (lib.lists.forEach [
          #        "elegant"
          #        "full"
          #        "fullmoon"
          #        "kendall"
          #        "macchiato"
          #        "stackoverflow"
          #      ] (n:
          #        config.packages.${"jsonresume-theme-${n}"}
          #        + "/lib/node_modules"));
          #};

          #resume-cli = pkgs.callPackage ./packages/resume-cli {};

          # TODO: Wrap with webserver?

          #themes-checks = let
          #  builderAttrs =
          #    pkgs.lib.filterAttrs
          #    (name: _: pkgs.lib.strings.hasPrefix "resume-" name)
          #    self.packages.${pkgs.system};
          #in
          #  pkgs.stdenv.mkDerivation {
          #    name = "themes-checks";
          #    src = ./template;
          #    buildPhase =
          #      ''
          #        cp resume.sample.json resume.json
          #      ''
          #      + (builtins.concatStringsSep "\n\n" (pkgs.lib.attrValues
          #        (pkgs.lib.mapAttrs (name: value: ''
          #            # Build using builder ${name}
          #            ${value}
          #            mv resume.html ${name}.html
          #          '')
          #          builderAttrs)));
          #    installPhase =
          #      ''
          #        mkdir $out
          #      ''
          #      + (builtins.concatStringsSep "\n\n" (pkgs.lib.attrValues
          #        (pkgs.lib.mapAttrs (name: _: "mv ${name}.html $out")
          #          builderAttrs)));
          #  };
        };

        #devShells.default = pkgs.mkShell {buildInputs = [pkgs.resumed pkgs.nodejs];};
        #apps.live = {
        #  type = "app";
        #  program =
        #    builtins.toString (pkgs.writeShellScript "resume-reload" "");
        #};
      };
      flake = {
        #  # Flake outputs
        #  templates.default = {
        #    path = ./template;
        #    description = "Template to build jsonresume with nix";
        #  };
        #  # Check output to run checks for all themes
        #  checks.themes = self.packages.themes-checks;
      };
    };
}
