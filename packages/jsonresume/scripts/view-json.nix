{
  jq,
  writeShellApplication,
  self,
  super,
  root,
  ...
}:
writeShellApplication {
  name = "resume-view-json";
  runtimeInputs = [
    jq
  ];
  text = ''
    jq '.' ${root.formats.json}
  '';
}
