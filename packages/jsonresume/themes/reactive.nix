{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage rec {
  pname = "jsonresume-theme-reactive";
  version = "0.5.0";

  meta = {
    description = "A flat and reactive JSON Resume theme.";
    homepage = "https://github.com/MoritzBru/jsonresume-theme-reactive";
    license = lib.licenses.mit;
  };

  src = fetchFromGitHub {
    owner = "MoritzBru";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-JXdCw/4aW/sYL2UVrw5WTyRLwb6fKKzpqAxobgih5CQ=";
  };

  dontNpmBuild = true;
  npmDepsHash = "sha256-KLYCXzNQP2ZZsvi7Xe4PK7D++sGpEQtzYzjLEJ/mQcI=";
}
