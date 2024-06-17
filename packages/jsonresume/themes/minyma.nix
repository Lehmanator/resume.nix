{ lib
, fetchFromGitHub
, buildNpmPackage
}:

buildNpmPackage rec {
  pname = "jsonresume-theme-minyma";
  version = "unstable-2024-03-27";
  dontNpmBuild = true;
  npmDepsHash = "sha256-MHqqvVDn6tVxRHH5XJQDTIKisMIXPPkB6ny5PMPSGqg=";

  src = fetchFromGitHub {
    owner = "godraadam";
    repo = pname;
    rev = "78b51b8eaa9a54f24b0230e0be4cb2dac168f38d";
    hash = "sha256-MJ5JxIAryDOJQFx7Sod+SBzGFApIZIqUSLNfgQahCYI=";
  };

  meta = with lib; {
    description = "A minymalistic theme for json-resume";
    homepage = "https://github.com/godraadam/jsonresume-theme-minyma";
    # license = licenses.unfree; # FIXME: nix-init did not found a license
    maintainers = with maintainers; [ ];
    mainProgram = "jsonresume-theme-minyma";
    platforms = platforms.all;
  };
}
