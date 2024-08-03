{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage rec {
  pname = "jsonresume-theme-hr-md";
  version = "unstable-2024-02-26";
  dontNpmBuild = true;
  npmDepsHash = "sha256-dpp8Amdjr5xSBH0w139CeS1NWpQnbzftxNCO/M8ST/A=";

  src = fetchFromGitHub {
    owner = "Greg-Bush";
    repo = pname;
    rev = "7a5cebf613fed7e4ae752f94f653070c60907097";
    hash = "sha256-zN1ILDEplCJYYrLiB/xY//FJV4FOs9XYxjldUKIy4eA=";
  };

  meta = with lib; {
    description = "JSON Resume Markdown Theme Repository";
    homepage = "https://github.com/Greg-Bush/jsonresume-theme-hr-md";
    license = licenses.mit;
    maintainers = with maintainers; [];
    mainProgram = "jsonresume-theme-hr-md";
    platforms = platforms.all;
  };
}
