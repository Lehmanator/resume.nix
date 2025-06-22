{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  ...
}:
buildNpmPackage rec {
  pname = "jsonresume-theme-stackoverflow";
  version = "2.0.2";

  src = fetchFromGitHub {
    owner = "phoinixi";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-8ACOuhGTWOC/pYdla7m6uKvw2TA6SBXuNlfMYsHUiyo=";
  };

  npmDepsHash = "sha256-H3bVs5VmK5eEPvxF85E8v+vAkGQPDjWM+mEKOJ95RMw=";
  dontNpmBuild = true;

  meta = {
    description = "Stack Overflow theme for JSON Resume";
    homepage = "https://github.com/phoinixi/jsonresume-theme-stackoverflow";
    license = lib.licenses.mit;
  };
}
