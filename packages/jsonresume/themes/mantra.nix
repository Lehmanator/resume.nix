{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  puppeteer-cli,
}:
# NOTE: Only works with pdf2
buildNpmPackage rec {
  pname = "jsonresume-theme-mantra";
  version = "0.3.1";
  src = fetchFromGitHub {
    owner = "zanetaylor";
    repo = pname;
    rev = "0e7d6792e1abacc8166a4d8e559144ea65273f09";
    hash = "sha256-B3xHKoOkqwz+FHG8S5YW2SGhEq0R0mWhsEvwo0ukQSM=";
  };
  dontNpmBuild = true;
  npmDepsHash = "sha256-zGnLjOlOouXneGhZx7MPdUzlDKkaNmmNGCsLBFMlxRw=";
  buildInputs = [puppeteer-cli];
  env.PUPPETEER_SKIP_DOWNLOAD = true;
  meta = {
    description = "The Mantra theme for JSON Resume.";
    homepage = "https://github.com/zanetaylor/jsonresume-theme-mantra";
    license = lib.licenses.mit;
  };
}
