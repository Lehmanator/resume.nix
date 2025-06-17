{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage rec {
  pname = "jsonresume-theme-crewshin";
  version = "unstable-20250521";
  # version = "0.31.0";

  src = fetchFromGitHub {
    owner = "crewshin";
    repo = pname;
    rev = "28008d8ce24771e65efacbf928caabc3a1bc4096";
    hash = "sha256-CoUFNeRujs/3DZVv8HZfV4t34H9vXkCQnSlO3156R0g=";
  };

  npmDepsHash = "sha256-mkyGx7iVCoHCIMIEqN9Oy3fVFf9tRWXwzbk/43b2Xd4=";
  dontNpmBuild = true;

  meta = {
    description = "A flat JSON Resume theme, compatible with the latest resume schema";
    homepage = "https://github.com/crewshin/jsonresume-theme-crewshin";
    license = lib.licenses.mit;
  };
}
