{
  buildNpmPackage,
  fetchFromGitHub,
  lib,
}: let
  pname = "HackMyResume";
  version = "v1.9.1";
  #
  # https://nixos.org/manual/nixpkgs/unstable/#language-javascript
  #
  # Builders:
  # - buildNpmPackage
  # - node2nix
  # - yarn2nix
  # - mkYarnPackage
  # - mkYarnModules
  # - npmlock2nix (https://github.com/nix-community/npmlock2nix)
  # - nix-npm-buildpackage (https://github.com/serokell/nix-npm-buildpackage)
  # - fetchNpmDeps
  # - prefetch-npm-deps
  #
in
  buildNpmPackage {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "hacksalot";
      repo = pname;
      rev = "ab6e7ee1a0f55608b531f4e644c298426291bb17";
      hash = lib.fakeHash;
    };

    npmDepsHash =
      lib.fakeHash; # "sha256-3GrHcwfu0rIPQ6e6SFa8Ve3VqL/KcEBRru9oAPAVGmo=";
    dontNpmBuild = false;

    meta = {
      description = "HackMyResume - Resume toolkit & format conversion";
      homepage = "https://github.com/hacksalot/${pname}";
    };
    #buildPhase = ''
    #  echo "Building ${pname} ..."
    #'';
    #installPhase = ''
    #  echo "Installing ${pname} ..."
    #'';
  }
