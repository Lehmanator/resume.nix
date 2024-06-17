{ inputs, ... }: {
  # imports = [ ];
  perSystem = { config, lib, pkgs, ... }: {
    devshells.jsonresume = {
      packages = [
        pkgs.resumed
        #pkgs.resume-cli
        pkgs.puppeteer-cli
        pkgs.python311Packages.weasyprint
        pkgs.nodePackages_latest.pnpm
      ];
      commands = [
        { name = "build-all";      command = "nix build .#jsonresume";      }
        { name = "build-data";     command = "nix build .#jsonresume-json"; }
        { name = "build-html";     command = "nix build .#jsonresume-html"; }
        { name = "build-pdf";      command = "nix build .#jsonresume-pdf";  }
        # { name = "validate";       command = "${lib.getExe pkgs.resume-cli} validate";             }
        # { name = "export-pdf";     command = "${lib.getExe pkgs.resume-cli} export --format pdf";  }
        # { name = "export-html";    command = "${lib.getExe pkgs.resume-cli} export --format html"; }
        # { name = "server";         command = "${lib.getExe pkgs.resume-cli} serve";                }
      ];
    };
  };
}
