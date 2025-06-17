{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage rec {
  pname = "jsonresume-theme-elegant";
  version = "1.16.2";

  src = fetchFromGitHub {
    repo = "jsonresume-theme-elegant";
    owner = "Lehmanator";
    rev = "v${version}";
    hash = "sha256-4/zd4sK2bsKKLbq/9C8RSY5ZMQaxfjWN4FblnZRLNsE=";
  };

  npmDepsHash = "sha256-SJXXbPgFh5G7WaPCW/5sr0pJMh15+5Bkl5p03ERTkQ0=";
  dontNpmBuild = true;

  # Delete broken symlinks
  fixupPhase = ''
    find . -xtype l -delete || true
  '';

  meta = {
    description = "Elegant theme for jsonresume";
    repo = "https://github.com/Lehmanator/jsonresume-theme-elegant";
    repo-parent = "https://github.com/jenshenneberg/jsonresume-theme-elegant-jkh";
    repo-original = "https://github.com/mudassir0909/jsonresume-theme-elegant";
    demo = "https://themes.jsonresume.org/theme/elegant";
    homepage = meta.repo;
    license = lib.licenses.mit;
  };
}
