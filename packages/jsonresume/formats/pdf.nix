{
  lib,
  stdenv,
  puppeteer-cli,
  self,
  super,
  root,
  src,
  ...
}: let
  data = import src;
  inherit (data.meta) theme version;
  theme-pkg = root.themes.${theme};
  html-pkg = super.html;
in
  stdenv.mkDerivation {
    inherit version;
    pname = "jsonresume-pdf-${theme}";
    allowSubstitutes = false;
    nativeBuildInputs = [puppeteer-cli theme-pkg html-pkg];
    src = theme-pkg;
    buildPhase = ''
      mkdir -p $out
      ${lib.getExe puppeteer-cli} print "${html-pkg}/index.html" $out/resume.pdf
    '';
  }
