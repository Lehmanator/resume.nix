{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
# NOTE: Only works with pdf1
buildNpmPackage rec {
  pname = "jsonresume-theme-onepage-web";
  version = "1.0.4";

  meta = {
    homepage = "https://github.com/mildronize/jsonresume-theme-onepage-web";
    description = "A compact theme for JSON Resume, Web View, designed for printing.";
    license = lib.licenses.free;
  };

  src = fetchFromGitHub {
    owner = "mildronize";
    repo = pname;
    rev = "d6c505fd88db59344c7ea3baac3a65489d66f6fe";
    hash = "sha256-hmQ92wLQcv7xW2hE4/w5GtXTPQel2kcuIYG6KuqWlvQ=";
  };

  dontNpmBuild = true;
  npmDepsHash = "sha256-gjhNnrVR2zOAKre2ZK8j9uyQHs9vZD98zzRAPYEMOZo=";
  env.PUPPETEER_SKIP_DOWNLOAD = true;
}
