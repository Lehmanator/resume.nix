{
  lib,
  puppeteer-cli,
  writeShellApplication,
  self,
  super,
  root,
  ...
}:
# TODO: Add assets
writeShellApplication {
  name = "jsonresume-builder-pdf-puppeteer";
  meta.description = "JSONResume script: Render PDF with Puppeteer";
  runtimeInputs = [puppeteer-cli];
  text = ''
    [[ $# -gt 0 ]] && outfile="$1" || outfile='./jsonresume.pdf'
    puppeteer print ${root.formats.html}/index.html "$outfile"
  '';
}
