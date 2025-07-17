{
  lib,
  resumed,
  stdenv,
  root,
  src ? ../../../src,
  extraThemes ? [],
  ...
} @ builderArgs: let
  templateName = builderArgs.templateName or "default";
  theme = builderArgs.theme or "stackoverflow";
  version = builderArgs.data.meta.version or "v0.0.1";

  # documentArgs.config.result.jsonresume.json.outPath;
  json = builderArgs.json or root.formats.json.outPath;
in
  stdenv.mkDerivation {
    # TODO: Make option for assetsDirectory
    inherit src version;
    pname = "resume-${templateName}-resumed-${theme}";

    nativeBuildInputs = [
      resumed
      root.themes.${theme}
    ];

    buildPhase = ''
      mkdir -p $out
      basedir="lib/node_modules/jsonresume-theme-${theme}"; # TODO: Some nodejs packages might use diff naming scheme
      entry="$basedir/index.js"                             # Used by theme: *most of them*
      [[ ! -f "$entry" ]] && entry="$basedir/dist/index.js" # Used by theme: crewshin
      [[ ! -f "$entry" ]] && entry="$basedir/dist/index.js" # Used by theme: eloquent
      resumed render ${json} --theme $entry --output $out/index.html
    '';

    meta = {
      homepage = "https://codeberg.org/Lehmanator/resume.nix";
      description = "JSONResume resumed HTML output using theme : ${theme}";
      license = lib.licenses.agpl3Plus;
    };
  }
