{
  lib,
  python3Packages,
  writeShellApplication,
  self,
  super,
  root,
  ...
}:
writeShellApplication {
  name = "pdf-weasyprint";
  meta.description = "Script to create a PDF document from an HTML page";
  runtimeInputs = [python3Packages.weasyprint];
  text = ''
    [[ $# -gt 0 ]] && outfile="$1" || outfile='./jsonresume.pdf'
    weasyprint --presentational-hints --media-type screen ${root.formats.html}/index.html "$outfile"
  '';
}
