{
  buildNpmPackage,
  fetchFromGitHub,
  lib,
}: let
  pname = "resume-cli";
  version = "3.0.8";
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
  # TODO: Possible to limit files in output?
  #  Currently passing $out/lib/node_modules/jsonresume-theme-${theme-name}/index.js
in
  buildNpmPackage {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "jsonresume";
      repo = pname;
      rev = "44cce172ea32723544ec973089341e6773d4cead";
      hash = "sha256-9rCY3mBQW6BdFJraVHHclihunCRpPGMn2NIoRgaleZY="; # lib.fakeHash;
    };

    npmDepsHash = "sha256-WhBNCHIAJQX/LgcM+mTQI9LJpAk20Jc+BNUn5c92v3c=";
    dontNpmBuild = false;

    #buildPhase = ''
    #  echo "Building ${pname} ..."
    #'';
    #installPhase = ''
    #  echo "Installing ${pname} ..."
    #'';

    meta = {
      description = "CLI to build jsonresume projects";
      homepage = "https://github.com/jsonresume/${pname}";
      #homepage = "https://jsonresume.org";
      #license = lib.license.mit;
    };
  }
