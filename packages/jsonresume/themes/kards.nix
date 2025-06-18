{
  lib,
  buildNpmPackage,
  fetchFromGitea,
}:
buildNpmPackage rec {
  pname = "jsonresume-theme-kards";
  version = "3.0.2";

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "Lehmanator";
    repo = pname;
    # rev = "v${version}";
    rev = "552957597ce78e1f5347228aefd61b05e25d045c";
    hash = "sha256-/tYb1wsBLHtTH+YXrZ42PUJ1J37BrIXA5USU42kjYhs=";
  };

  npmDepsHash = "sha256-84g6ecjdZxLBNqlfaVjWRiXcaypIhj99XT5U2fiEvZg=";
  dontNpmBuild = true;

  fixupPhase = ''
    find . -xtype l -delete || true
  '';

  meta = {
    description = "Slideshow-like theme for JSONResume.";
    homepage = "https://github.com/XuluWarrior/jsonresume-theme-kards";
    license = lib.licenses.mit;
  };
}
