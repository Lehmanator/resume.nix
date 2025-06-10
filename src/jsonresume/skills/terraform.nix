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
    name = "Terraform";
    keywords = ["DevOps" "infrastructure" "infrastructure-as-code"];
    # level = "Beginner";
  }
