{
  lib,
  puppeteer-cli,
  writeShellApplication,
  root,
  ...
}:
# TODO: Add assets
writeShellApplication {
  name = "jsonresume-builder-pdf-puppeteer";
  runtimeInputs = [puppeteer-cli];
  text = ''
    [[ $# -gt 0 ]] && outfile="$1" || outfile='./jsonresume.pdf'
    if [[ -d "${root.formats.html.outPath}" ]]; then
      puppeteer print ${root.formats.html}/index.html "$outfile"
    else
      puppeteer print "${root.formats.html.outPath}" "$outfile"
    fi
  '';

  meta = {
    description = "JSONResume script: Render PDF with Puppeteer";
    homepage = "https://codeberg.org/Lehmanator/resume.nix";
    license = lib.licenses.agpl3Plus;
  };
}
