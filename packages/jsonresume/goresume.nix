{
  lib,
  buildGoModule,
  fetchFromGitHub,
  extraThemes ? [],
} @ packageArgs:
#
# TODO: Handle passing extra themes
#
buildGoModule rec {
  pname = "goresume";
  version = "0.3.21";
  # version = "0.3.22-unstable-2025-06-24";

  src = fetchFromGitHub {
    owner = "nikaro";
    repo = "goresume";
    rev = version;
    hash = "sha256-g/8foi2lvWLe+jqRfbkoFLixIeRkFnv+jCmUqss6u5k=";
    # rev = "611843f1237570b359b91dd5ebeb2ff8820a7849";
    # hash = lib.fakeHash;
  };

  vendorHash = "sha256-a8DZTT2sSAakRCJyoocmGsMDsxh/Puzf2GG3rA8EXZE=";
  # vendorHash = lib.fakeHash;

  ldflags = ["-s" "-w"];

  # Playwright Host validation warning:
  # ╔══════════════════════════════════════════════════════╗
  # ║ Host system is missing dependencies to run browsers. ║
  # ║ Missing libraries:                                   ║
  # ║     libglib-2.0.so.0                                 ║
  # ║     libgobject-2.0.so.0                              ║
  # ║     libnss3.so                                       ║
  # ║     libnssutil3.so                                   ║
  # ║     libsmime3.so                                     ║
  # ║     libnspr4.so                                      ║
  # ║     libdbus-1.so.3                                   ║
  # ║     libatk-1.0.so.0                                  ║
  # ║     libatk-bridge-2.0.so.0                           ║
  # ║     libcups.so.2                                     ║
  # ║     libgio-2.0.so.0                                  ║
  # ║     libdrm.so.2                                      ║
  # ║     libexpat.so.1                                    ║
  # ║     libX11.so.6                                      ║
  # ║     libXcomposite.so.1                               ║
  # ║     libXdamage.so.1                                  ║
  # ║     libXext.so.6                                     ║
  # ║     libXfixes.so.3                                   ║
  # ║     libXrandr.so.2                                   ║
  # ║     libgbm.so.1                                      ║
  # ║     libxcb.so.1                                      ║
  # ║     libxkbcommon.so.0                                ║
  # ║     libpango-1.0.so.0                                ║
  # ║     libcairo.so.2                                    ║
  # ║     libudev.so.1                                     ║
  # ║     libasound.so.2                                   ║
  # ║     libatspi.so.0                                    ║
  # ╚══════════════════════════════════════════════════════╝
  buildInputs = [
    # libnss_nis
    # libglibutil
    # libdrm
  ];

  meta = {
    description = "Build HTML/PDF resume from JSON/YAML/TOML";
    homepage = "https://nikaro.github.io/goresume/";
    repo = "https://github.com/nikaro/goresume";
    changelog = "https://github.com/nikaro/goresume/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.mit;
    mainProgram = "goresume";
  };
}
