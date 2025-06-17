{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage rec {
  pname = "jsonresume-theme-macchiato";
  version = "unstable-20250428";

  src = fetchFromGitHub {
    owner = "jhcotton";
    rev = "2106f1754bad17f566669be056b72d3e7f86bb4f";
    hash = "sha256-FZjTn0o1cYxg0LoxJMHmaVJTdSIvylT8lgc6B/4jdFQ=";
    repo = pname;
  };

  npmDepsHash = "sha256-bA9O+4sfrhQmLnBhnXKwK/TGwJbv2Z6ndK2nFwvmv+A=";

  dontNpmBuild = true;
  PUPPETEER_SKIP_CHROMIUM_DOWNLOAD = 1;

  fixupPhase = ''
    find . -xtype l -delete || true
  '';

  meta = {
    description = "Simple JSONResume theme (based on Caffeine theme) ☕️+🥛";
    homepage = "https://github.com/jhcotton/jsonresume-theme-macchiato";
    demo = "https://biosan.github.io/jsonresume-theme-macchiato";
    license = lib.licenses.mit;
  };
}
