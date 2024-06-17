{writeTextFile}:
# TODO: Handle validation against schema
writeTextFile {
  name = "resume.json";
  text = builtins.toJSON (import ../src/jsonresume.nix);
  #lib.attrsets.filterAttrs (n: v: n != "meta")
}
