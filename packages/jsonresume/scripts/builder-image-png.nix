{
  lib,
  puppeteer-cli,
  writeShellApplication,
  root,
  ...
}:
writeShellApplication {
  name = "builder-image-png";
  runtimeInputs = [puppeteer-cli];

  text = ''
    [[ $# -gt 0 ]] && outfile="$1" || outfile='./resume.png'

    puppeteer screenshot \
      --sandbox false    \
      ${root.formats.html}/index.html \
      "$outfile"
  '';

  meta = {
    description = "Script to create a PNG screenshot of your HTML";
    homepage = "https://codeberg.org/Lehmanator/resume.nix";
    license = lib.licenses.agpl3Plus;
  };
}
