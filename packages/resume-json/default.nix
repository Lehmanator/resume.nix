{writeTextFile}:
writeTextFile {
  name = "resume.json";
  text = builtins.toJSON (import ../../src/resume.nix);
  #lib.attrsets.filterAttrs (n: v: n != "meta")
}
