{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types;
  cfg = config.resume;
in {
  imports = [];

  options.resume = mkOption {
    description = "Attrsets containing resume data";
    type = types.attrsOf (types.submodule ({name, ...}: {
      freeformType = (pkgs.formats.json {}).generate;
      options = {
        enable = mkEnableOption "Resume: ";
        type = mkOption {
          type = types.enum ["jsonresume" "rendercv" "goresume" "hackmyresume"];
          description = "The class of the resume data";
        };
        name = mkOption {
          type = types.nonEmptyStr;
          description = "The name of this document.";
          example = "system-administrator";
          default = name;
        };
        settings = mkOption {
          description = "Settings controlling the handling of the resume data";
          type = types.submodule {
            freeformType = types.attrs;
            options = {
            };
          };
        };
        # ----
      };
    }));
  };

  config = {
  };
}
