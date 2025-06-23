{
  lib,
  chromium,
  puppeteer-cli,
  writeShellApplication,
  root,
  ...
}:
# TODO: Add assets
writeShellApplication {
  name = "jsonresume-builder-pdf-puppeteer";
  runtimeInputs = [
    chromium
    chromium.sandbox
    puppeteer-cli
  ];

  text = ''
    [[ $# -gt 0 ]] && outfile="$1" || outfile='./jsonresume.pdf'
    if [[ -d "${root.formats.html.outPath}" ]]; then
      htmlPath="${root.formats.html}/index.html"
    else
      htmlPath="${root.formats.html.outPath}"
    fi
    OLD_CONFIG_HOME="$XDG_CONFIG_HOME"
    XDG_CONFIG_HOME="$(mktemp -d)" \
    PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=1 \
    PUPPETEER_SKIP_DOWNLOAD=1 \
    puppeteer print --sandbox false "$htmlPath" "$outfile"

    XDG_CONFIG_HOME="$OLD_CONFIG_HOME"
  '';

  meta = {
    description = "JSONResume script: Render PDF with Puppeteer";
    homepage = "https://codeberg.org/Lehmanator/resume.nix";
    license = lib.licenses.agpl3Plus;
  };
}
