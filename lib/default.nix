{
  self,
  super,
  root,
  lib,
  # , pkgs
  ...
}: let
  l = lib // builtins;
in {
  getFileExtension = file: lib.last (lib.splitString "." (builtins.baseNameOf file));
  getFileBasename = file: builtins.head (lib.splitString "." (builtins.baseNameOf file));
  importData = src:
    if ((lib.hasSuffix ".yaml" src) || (lib.hasSuffix ".yml" src))
    then lib.importJSON src
    else if lib.hasSuffix ".json" src
    then lib.importJSON src
    else if lib.hasSuffix ".toml" src
    then lib.importTOML src
    else if lib.hasSuffix ".nix" src
    then import src
    else import src;

  # --- Data Manipulation ----------------------------------
  # TODO: Replace meta.version with incremented version
  # TODO: Replace meta.lastModified with update/build time?
  # TODO: Replace meta.canonical with git forge link based on path
  # - Auto add project link to jsonresume data?

  # Replaces the theme in a resume.
  replaceTheme = src: theme: (self.importData src) // (lib.setAttrByPath ["meta" "theme"] theme);
  version = {
    get = data: lib.removePrefix "v" data.meta.version;
    increment = data: let
      old = self.version.get data;
    in
      lib.attrsets.recursiveUpdate {
        meta = {
          #lastModified = "";
          #canonical = "https://raw.githubusercontent.com/${u}/${r}/${b}/${p}";
          version = "${lib.versions.majorMinor old}.${(lib.versions.patch old) + 1}";
        };
      };
  };

  # --- Conversion Process ---------------------------------
  generateFile = name: self.mapToGenerator (self.getFileExtension name);
  writeFile = name: data: builtins.toFile "jsonresume-${name}" ((self.generateFile name) {} data);
  # writeFile = name: data: pkgs.writeText "jsonresume-${name}" (self.generateFile name data);

  # TODO: Insert wrappers here to pretty-print
  convertFile = src: dst: self.writeFile dst (self.importData src);

  # --- Mappers -------------------------------------------
  # TODO: Make similar for pretty-print wrapper
  # Map file extensions to associated generator
  mapToGenerator = ext:
    {
      # lib.generators
      nix = lib.generators.toPretty; # Pretty-printed Nix
      lua = lib.generators.toLua; # Pretty-printed Lua
      dhall = lib.generators.toDhall; # Not pretty-printed
      dconf = lib.generators.toDconfINI; # Broken, unknown reason, probably same as INI
      plist = lib.generators.toPlist; # Pretty-printed
      ini = lib.generators.toINI; # Broken, attrsets not supported
      gitconfig = lib.generators.toGitINI; # Broken, attrsets not supported
      json = lib.generators.toJSON; # Not pretty-printed, wrap with jq to format
      kv = lib.generators.toKeyValue; # Broken, attrsets not supported
      yaml = lib.generators.toYAML; # Same as JSON, wrapper with json2yaml needed
    }
    .${
      ext
    }
    or lib.generators.toJSON;

  # mapToFormat = ext: (({
  #   # pkgs.formats
  #   properties = pkgs.formats.javaProperties {};
  #   exs = pkgs.formats.elixirConf {};
  #   py = pkgs.formats.pythonVars {};
  #   cfg = pkgs.formats.libconfig {};
  #   kv = pkgs.formats.keyValue {};
  #   ini = pkgs.formats.ini {}; #gitIni iniWithGlabalSection
  #   hocon = pkgs.formats.hocon {};
  #   java = pkgs.formats.javaProperties {};
  #   json = pkgs.formats.json {};
  #   toml = pkgs.formats.toml {};
  #   yaml = pkgs.formats.yaml {};

  #   # systemd = pkgs.formats.systemd {};
  #   # unit = pkgs.formats.systemd {};
  #   # service = pkgs.formats.systemd {};
  #   # timer = pkgs.formats.systemd {};
  #   # socket = pkgs.formats.systemd {};
  #   # slice = pkgs.formats.systemd {};
  #   # mount = pkgs.formats.systemd {};
  #   # automount = pkgs.formats.systemd {};
  # }).${ext} or (pkgs.formats.${ext} or pkgs.formats.json {})).generate;
}
