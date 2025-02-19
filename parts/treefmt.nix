{
  inputs,
  self,
  ...
}: {
  imports = [inputs.treefmt-nix.flakeModule];
  perSystem = {pkgs, ...}: {
    treefmt = {
      enableDefaultExcludes = true;
      package = pkgs.treefmt;

      flakeCheck = false;
      flakeFormatter = true;

      projectRoot = self;

      programs = {
        # --- JavaScript ---
        # TODO: Enable on dir: `../packages/themes-jsonresume/**`
        prettier.enable = false;

        # --- JSON ---
        formatjson5 = {
          enable = false;
          package = pkgs.formatjson5;
          excludes = [];
          includes = ["*.json5" "*.json"];
          indent = 2;
          noTrailingCommas = false;
          oneElementLines = true;
          sortArrays = false;
        };
        jsonfmt = {
          enable = true;
          package = pkgs.jsonfmt;
          excludes = ["*.json5"];
          includes = ["*.json"];
        };

        # --- Jsonnet ---
        jsonnet-lint.enable = false;
        jsonnetfmt.enable = false;

        # --- Markdown ---
        mdformat = {
          enable = true;
          package = pkgs.python3Packages.mdformat;
          excludes = [];
          # includes = ["docs/*.md" "README.md"];
          includes = ["*.md"];
          priority = 2;
          settings.end-of-line = "keep";
          settings.number = false;
          settings.wrap = 120;
        };

        # Markdown code block preprocessor
        mdsh = {
          enable = true;
          package = pkgs.mdsh;
          excludes = [];
          includes = ["*.md"];
          priority = 1;
        };

        # --- Nickel ---
        nickel.enable = false;

        # --- Nix ---
        alejandra = {
          enable = true;
          includes = ["*.nix"];
          excludes = ["packages/*.nix"];
        };
        nixfmt.enable = false;
        nixfmt-rfc-style = {
          enable = true;
          package = pkgs.nixfmt-rfc-style;
          excludes = ["flake.nix"];
          includes = ["packages/*.nix"];
          priority = 1;
        };
        nixpkgs-fmt.enable = false;
        deadnix.enable = false;
        statix.enable = false;

        # --- Nushell ---
        nufmt.enable = false;

        # --- YAML ---
        # GitHub Actions
        actionlint.enable = false;
        yamlfmt.enable = true;
      };
    };
  };
}
