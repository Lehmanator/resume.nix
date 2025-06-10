{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage rec {
  pname = "jsonresume-theme-ResumeHub";
  version = "0.0.11";

  src = fetchFromGitHub {
    owner = "Solsem-Consulting";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-VVDeTDIMvaD9cs5wr8mtU/FpHPTRlxq9VxKD5CLrGvI=";
  };

  npmDepsHash = "sha256-7bPF3iOYM76Goc11Gjngvo/9647R7hh9n+W34poI6BU=";
  dontNpmBuild = true;

  meta = {
    description = "ResumeHub theme for JSON Resume";
    homepage = "https://github.com/Solsem-Consulting/jsonresume-theme-ResumeHub";
    license = lib.licenses.mit;
  };
}
