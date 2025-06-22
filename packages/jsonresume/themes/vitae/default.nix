{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  fetchNpmDeps,
}:
buildNpmPackage rec {
  pname = "jsonresume-theme-vitae";
  version = "unstable-20250505";
  # version = "1.1.0";

  src = fetchFromGitHub {
    owner = "kasperab";
    repo = pname;
    rev = "9f7020f9402868dc6316ed7feed4203c05108fa2";
    hash = "sha256-7N0949/S2WLC324RZzTbgnDWnYWTbpLfWllUjzpcULE=";
  };

  dontNpmBuild = true;
  npmDepsHash = "sha256-66ZFEwzSa7ZU4+vxdsrtotqB+As4Fzj6x4Pctj4rx24=";
  npmDeps = fetchNpmDeps {
    name = "${pname}-npm-deps";
    hash = npmDepsHash;
    src = lib.fileset.toSource {
      root = ./.;
      fileset = lib.fileset.unions [./package-lock.json ./package.json];
    };
  };

  postPatch = ''
    mkdir -p node_modules
    cp ${./package-lock.json} package-lock.json
  '';

  meta = {
    description = "Simple theme for JSON Resume with support for light and dark mode";
    homepage = "https://github.com/kasperab/jsonresume-theme-vitae";
    license = lib.licenses.mit;
  };
}
