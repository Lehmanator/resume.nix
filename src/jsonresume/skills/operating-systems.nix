{
  extraKeywords ? [],
  hide ? [],
  overrides ? {},
  ...
} @ args: let
  base = builtins.removeAttrs args ["extraKeywords" "hide" "overrides"];
  merge = a: builtins.removeAttrs (base // a // {keywords = a.keywords or [] ++ extraKeywords;} // overrides) hide;
in
  merge
  {
    name = "Operating Systems";
    keywords = ["Windows" "MacOS" "Linux" "Android" "iOS" "NixOS" "Arch Linux" "Debian"];
  }
