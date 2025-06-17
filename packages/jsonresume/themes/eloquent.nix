{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage {
  pname = "jsonresume-theme-eloquent";
  version = "5.0.0";

  src = fetchFromGitHub {
    owner = "thibaudcolas";
    repo = "jsonresume-theme-eloquent";
    rev = "382a37f8b0c1ccc4f5c57b258ddeec8fa9802696";
    hash = "sha256-S2f30qsw5p84JHCO5Oy0cAaeUZxHH8uQo6OIPkQgJJU=";
  };

  npmDepsHash = "sha256-ebiAR3/wOqjV2wxRrabr8RGh5Wa8UEGYLCmuM+SHXMk=";
  dontNpmBuild = true;

  # installPhase = ''
  #   mkdir -p $out
  #   cp ./lib/resume.js $out/index.js
  # '';

  meta = {
    description = " An eloquent JSON Resume theme: fluent, persuasive, for developers.";
    homepage = "https://github.com/thibaudcolas/jsonresume-theme-eloquent";
    license = lib.licenses.mit;
  };
}
