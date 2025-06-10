{
  overrides ? {},
  hide ? {},
  extraKeywords ? [],
  ...
} @ args: let
  base = builtins.removeAttrs args ["extraKeywords" "hide" "overrides"];
  merge = a: builtins.removeAttrs (base // a // {keywords = a.keywords or [] ++ extraKeywords;} // overrides) hide;
in
  merge
  {
    name = "Microsoft Azure";
    keywords = ["DevOps" "cloud computing" "OAuth2" "directory server" "Virtual Machines"];
    level = "Intermediate";
  }
