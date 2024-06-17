{ lib
, buildNpmPackage
, fetchFromGitHub
}:

buildNpmPackage rec {
  pname = "jsonresume-theme-hired";
  version = "unstable-2024-03-29";
  dontNpmBuild = true;
  npmDepsHash = "sha256-xrCaxNntDo/f78K0/PMn9yeVEE5KuksNUkOImHpvQbM=";

  src = fetchFromGitHub {
    owner = "aplocher";
    repo = pname;
    rev = "3501be0858f89e94e51e9c5119f7d13ace168c6e";
    hash = "sha256-UYRFT7cKKh+96oqAlkmcermjxDp2CWiY1OS5XmtV0nQ=";
  };

  meta = with lib; {
    description = "";
    homepage = "https://github.com/aplocher/jsonresume-theme-hired";
    license = licenses.mit; # FIXME: nix-init did not found a license
    maintainers = with maintainers; [ ];
    mainProgram = "jsonresume-theme-hired";
    platforms = platforms.all;
  };
}
