{
  lib,
  chawan,
  writeShellApplication,
  self,
  super,
  root,
  ...
}: let
  path = lib.removePrefix "file://" "${root.formats.html}/index.html";
in
  writeShellApplication {
    name = "resume-view-html";
    runtimeInputs = [
      chawan
      root.formats.html
    ];
    text = ''
      cha ${root.formats.html}/index.html
    '';
  }
