{
  buildNpmPackage,
  fetchFromGitHub,
}: let
  pname = "jsonresume-theme-elegant";
  version = "1.16.1";
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
      owner = "mudassir0909";
      repo = pname;
      rev = "1b38dae2f9fcdf0e4a5d03d2a737b88303ff6305";
      hash = "sha256-AhWWBA5D1LgBQtIjPQMZICngBpbGmBGRpv/7SHsSfXc=";
    };

    npmDepsHash = "sha256-3GrHcwfu0rIPQ6e6SFa8Ve3VqL/KcEBRru9oAPAVGmo=";
    dontNpmBuild = true;
    dontStrip = false;

    meta = {
      description = "Elegant theme for jsonresume";
      homepage = "https://github.com/mudassir0909/jsonresume-theme-elegant";
    };
    #buildPhase = ''
    #  echo "Building ${pname} ..."
    #'';
    #installPhase = ''
    #  echo "Installing ${pname} ..."
    #'';
  }
