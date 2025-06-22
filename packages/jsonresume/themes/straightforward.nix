{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage rec {
  pname = "jsonresume-theme-straightforward";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "slugstack";
    repo = pname;
    rev = "31087385c6cf40f8ebf0e5ac4562f24c1373b110";
    hash = "sha256-oTLewCOGaelYaLDHAeYkPpdIVNQJgt18Nco8qwZ1oXQ=";
  };

  dontNpmBuild = true;
  npmDepsHash = "sha256-vA5kjdTwzNkTn9LcFvQG+xlZuIPh7aYCv7naoMdnjhg=";
  env.PUPPETEER_SKIP_DOWNLOAD = true;

  # Delete broken symlinks
  fixupPhase = ''
    find . -xtype l -delete || true
  '';

  meta = {
    description = "a straightforward jsonresume theme.";
    homepage = "https://github.com/slugstack/jsonresume-theme-straightforward";
    license = lib.licenses.mit;
  };
}
