{
  resumed,
  writeShellApplication,
  self,
  super,
  root,
  ...
}:
writeShellApplication {
  name = "jsonresume-init";
  runtimeInputs = [
    resumed
  ];
  text = ''
    [[ $# -gt 0 ]] && outfile=$1 || outfile='./jsonresume.json'
    resumed init $outfile;
  '';

  meta.description = "Script to initialize a new JSONResume";
}
