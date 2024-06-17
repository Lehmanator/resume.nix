{
  self,
  super,
  root,
  symlinkJoin,
  ...
}:
symlinkJoin {
  name = "jsonresume-themes-all";
  paths = builtins.attrValues (builtins.removeAttrs super ["all" "default"]);
}
