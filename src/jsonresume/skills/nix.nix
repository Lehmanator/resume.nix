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
    name = "Nix";
    keywords = ["Nix" "NixOS" "reproducible builds" "functional programming" "DevOps" "immutability"];
  }
