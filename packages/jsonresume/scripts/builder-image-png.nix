{
  lib,
  puppeteer-cli,
  writeShellApplication,
  self,
  super,
  root,
  ...
}:
writeShellApplication {
  name = "builder-image-png";
  meta.description = "Script to create a PNG screenshot of your HTML";
  runtimeInputs = [puppeteer-cli];
  text = ''
    [[ $# -gt 0 ]] && outfile="$1" || outfile='./jsonresume.png'

    puppeteer screenshot \
      ${root.formats.html}/index.html \
      "$outfile"
      # --viewport 1920x1080 \
  '';
}
