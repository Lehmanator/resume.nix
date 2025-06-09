{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}: let
  pname = "jsonresume-theme-even";
  version = "0.23.0";
in
  buildNpmPackage {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "rbardini";
      repo = pname;
      rev = "af5d92256fea661c0ed8d8fe624bb1300ed823d3";
      hash = "sha256-2pLoBvuWGsPyvoeRRjpCF9gPkcFb2ixl7L8iZGpJxPA=";
    };

    npmDepsHash = "sha256-vQDf4P5UQfLeQmpm3OBT1hg3wfiXMRA3hZvZqpz/e84=";
    dontNpmBuild = true;

    meta = {
      description = "Simple to the point theme for JSON Resume, based on the short theme.";
      homepage = "https://github.com/rbardini/jsonresume-theme-even";
      license = lib.licenses.mit;
    };

    # "meta": {
    #   "themeOptions": {
    #     "colors": {
    #       "background": ["#ffffff", "#191e23"],
    #       "dimmed": ["#f3f4f5", "#23282d"],
    #       "primary": ["#191e23", "#fbfbfc"],
    #       "secondary": ["#6c7781", "#ccd0d4"],
    #       "accent": ["#0073aa", "#00a0d2"]
    #     }
    #   }
    # }
  }
