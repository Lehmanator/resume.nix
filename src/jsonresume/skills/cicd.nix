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
    name = "CI / CD";
    keywords = ["DevOps" "GitHub Actions" "GitHub Pages" "Forgejo Actions" "Codeberg Pages"];
    level = "Intermediate";
  }
