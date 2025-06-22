{
  buildNpmPackage,
  fetchFromGitHub,
  lib,
  ...
}:
# https://github.com/hacksalot/HackMyResume
buildNpmPackage rec {
  pname = "HackMyResume";
  version = "v1.9.1-beta";

  src = fetchFromGitHub {
    owner = "hacksalot";
    repo = pname;
    rev = "ab6e7ee1a0f55608b531f4e644c298426291bb17";
    hash = lib.fakeHash;
  };

  npmDepsHash = lib.fakeHash; # "sha256-3GrHcwfu0rIPQ6e6SFa8Ve3VqL/KcEBRru9oAPAVGmo=";
  dontNpmBuild = false;

  meta = {
    description = "HackMyResume - Resume toolkit & format conversion";
    homepage = "https://fluentdesk.com/hackmyresume";
    repo = "https://github.com/hacksalot/HackMyResume";
    license = lib.licenses.mit;
  };

  # buildPhase = ''
  #   echo "Building ${pname} ..."
  # '';
  # installPhase = ''
  #   echo "Installing ${pname} ..."
  # '';
}
