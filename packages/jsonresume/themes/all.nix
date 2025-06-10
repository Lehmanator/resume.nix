{
  lib,
  self,
  super,
  root,
  symlinkJoin,
  ...
}:
symlinkJoin {
  name = "jsonresume-themes-all";
  paths = builtins.attrValues (builtins.removeAttrs super ["all" "default"]);
  meta = {
    description = "Combined JSONResume themes";
    homepage = "https://codeberg.org/Lehmanator/resume.nix";
    license = lib.licenses.agpl3Plus;
  };
}
