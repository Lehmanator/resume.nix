{inputs, ...}: {
  perSystem = {
    config,
    lib,
    pkgs,
    ...
  }: {
    devshells = rec {
      default = jsonresume;
      jsonresume = {
        devshell = {
          meta = {
            description = "Development Shell for JSON-Resume";
            homepage = "https://github.com/Lehmanator/resume.nix";
          };
          motd = ''
            {202}🔨 Welcome to JSON-Resume devshell{reset}
            $(type -p menu &>/dev/null && menu)
          '';
          # Use the top-level directory of the working tree
          prj_root_fallback = {eval = "$(git rev-parse --show-toplevel)";};
          # startup.name={deps=["startup_step_name"]; text=""; env=[{name=""; value=""; prefix="bin"; eval="$PRJ_ROOT/.cache"; unset=false; }]; };
        };

        packagesFrom = with pkgs; []; # TODO: config.packages.jsonresume-formats-all;
        packages = with pkgs; [
          jq
          yq
          bat
          resumed
          #resume-cli
          puppeteer-cli
          python3Packages.weasyprint
          nodePackages_latest.pnpm
        ];

        # TODO: Watchdog server & rebuild
        # TODO: Run CI/CD tests / GitHub Actions workflows
        commands = [
          # --- Editing ---
          {
            name = "jsonresume-edit";
            category = "[jsonresume edit]";
            command = "$EDITOR ./src/jsonresume.nix"; # TODO: Variable path
            help = "Edit your jsonresume data";
          }

          # --- Building ---
          {
            name = "jsonresume-build-all";
            category = "[jsonresume build]";
            command = "nix build .#jsonresume";
            help = "Build jsonresume - all formats";
          }
          {
            name = "jsonresume-build-data";
            category = "[jsonresume build]";
            command = "nix build .#jsonresume-json";
            help = "Build jsonresume - JSON format";
          }
          {
            name = "jsonresume-build-html";
            category = "[jsonresume build]";
            command = "nix build .#jsonresume-html";
            help = "Build jsonresume - HTML format";
          }
          {
            name = "jsonresume-build-pdf";
            category = "[jsonresume build]";
            command = "nix build .#jsonresume-pdf";
            help = "Build jsonresume - PDF format";
          }

          # --- Previewing ---
          {
            name = "jsonresume-preview-html";
            category = "[jsonresume preview]";
            command = "nix build .#jsonresume-pdf && ${pkgs.xdg-utils}/bin/xdg-open ./result/index.html";
            help = "Build & preview your jsonresume HTML";
          }
          {
            name = "jsonresume-preview-pdf";
            category = "[jsonresume preview]";
            command = "nix build .#jsonresume-pdf && ${pkgs.xdg-utils}/bin/xdg-open ./result/resume.pdf";
            help = "Build & preview your jsonresume PDF";
          }
          # { name = "validate";       command = "${lib.getExe pkgs.resume-cli} validate";             }
          # { name = "export-pdf";     command = "${lib.getExe pkgs.resume-cli} export --format pdf";  }
          # { name = "export-html";    command = "${lib.getExe pkgs.resume-cli} export --format html"; }
          # { name = "server";         command = "${lib.getExe pkgs.resume-cli} serve";                }
        ];

        # interactive.name = {
        #   deps = ["other_steps"];
        #   text = ''
        #   '';
        # };

        # TODO: Formatting?
        serviceGroups.watchdog = let
          fzz = "${pkgs.funzzy}/bin/fzz";
          fd = lib.getExe pkgs.fd;
          nix-file-regex = ".+\.nix$";
          nix-files-regex = "(.+/)*" + nix-file-regex;
          data-regex = "(jsonresume.*\.(nix|ini|json|toml|ya?ml)|photo\.(png|jpe?g|webp|svg))$";
          # TODO: Custom NPM packages for JSONResume templates.
        in {
          description = "File watcher service for jsonresume data source files.";
          name = "watcher-jsonresume";
          services = {
            watch-jsonresume-data = {
              name = "file-watcher-jsonresume-data";
              command = "${fd} '${data-regex}' $PRJ_ROOT/src | ${fzz} 'nix build'";
            };
            watch-jsonresume-packages = {
              name = "watch-files-jsonresume-packages";
              command = "${fd} '${nix-files-regex}' PRJ_ROOT/packages | ${fzz} 'nix build'";
            };
            watch-jsonresume-glue = {
              name = "watch-files-glue";
              command = "${fd} '${nix-files-regex}' | ${fzz} 'nix build'";
            };
          };
        };
      };
    };
  };
}
