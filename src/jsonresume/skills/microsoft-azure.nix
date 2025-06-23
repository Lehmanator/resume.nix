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
    level = "Master";
    keywords = [
      "Directory servers"
      "Domain controllers"
      "Cloud computing"
      "Cloud VMs"
      "Office 365"
      "OAuth2"
    ];
  }
