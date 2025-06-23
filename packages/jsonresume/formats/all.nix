{
  lib,
  linkFarm,
  stdenv,
  writers,
  self,
  super,
  root,
  src ? ../../../src/jsonresume/default.nix,
  domains ? ["resume.samlehman.me"],
  ...
} @ args: let
  basename = builtins.head (lib.splitString "." (builtins.baseNameOf src));
  data = import src {
    inherit lib;
  };
in
  # TODO: Automatically pickup format names.
  (linkFarm "jsonresume-all-${basename}" [
    # Input formats
    {
      name = "${basename}.nix";
      path = super.nix;
    }
    {
      name = "${basename}.json";
      path = super.json;
    }
    {
      name = "${basename}.toml";
      path = super.toml;
    }
    {
      name = "${basename}.yaml";
      path = super.yaml;
    }

    # Output formats
    {
      name = "${basename}.md";
      path = super.markdown;
    }
    {
      name = "${basename}.html";
      path = "${super.html.outPath}/index.html";
    }
    {
      name = "${basename}.pdf";
      path = super.pdf;
    }
    {
      name = "${basename}.png";
      path = "${super.image.outPath}/resume.png";
    }

    # GitHub / Codeberg Pages outputs
    {
      name = "CNAME";
      path = writers.writeText "CNAME" (builtins.head domains);
    }
    {
      name = ".domains";
      path = writers.writeText ".domains" (lib.strings.concatLines domains);
    }
  ])
  // {
    version = args.version or data.meta.version or "v0.0.1";
    meta = {
      description = "JSONResume outputs: All formats for variant: ${basename}.";
      homepage = "https://codeberg.org/Lehmanator/resume.nix";
      license = lib.licenses.agpl3Plus;
    };
  }
