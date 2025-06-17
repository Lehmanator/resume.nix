{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
# INFO: Recommended: Include `meta.language = "en"` in JSONResume data
buildNpmPackage rec {
  pname = "jsonresume-theme-class";
  version = "unstable-20250428";

  src = fetchFromGitHub {
    owner = "jhcotton";
    repo = pname;
    rev = "d3b01b3c9b48604be3b6cef23687e9385d050a7a";
    hash = "sha256-pHo2DifNxzLgXZmRMITb398F1PPPZsWnp4UoVeXVaEo=";
  };

  npmDepsHash = "sha256-TD1UdF8jsJgD+7Ff6t+7dlxKqYq7ykrk7ZwiBk/11K8=";
  dontNpmBuild = true;

  env.PUPPETEER_SKIP_DOWNLOAD = true;

  meta = {
    description = "A modern theme for JSON Resume which is self-contained. The content of the resume will work offline and can be hosted without depending on or making requests to third-party servers.";
    homepage = "https://github.com/jhcotton/jsonresume-theme-class";
    license = lib.licenses.mit;
  };
}
