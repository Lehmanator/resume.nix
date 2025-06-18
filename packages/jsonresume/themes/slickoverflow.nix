{
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage rec {
  pname = "jsonresume-theme-slickoverflow";
  version = "0.0.2-20250618";

  src = fetchFromGitHub {
    owner = "adavila0703";
    repo = pname;
    rev = "76da0b66d8a3146f84dc26f28f542bfd6f372fb8";
    hash = "sha256-lRmenOjUnKiaBdlQD3Cim+0QRLeJXvqdBOg/6ZSN5EA=";
  };

  npmDepsHash = "sha256-Q9hMei1hj7vycxU7FA2MwxPNehLeI4NTzeG1HUXgfhc=";
  dontNpmBuild = true;
  dontStrip = false;

  fixupPhase = ''
    find . -xtype l -delete || true
  '';

  meta = {
    description = "SlickOverflow theme for jsonresume";
    homepage = "https://github.com/adavila0703/jsonresume-theme-slickoverflow";
  };
}
