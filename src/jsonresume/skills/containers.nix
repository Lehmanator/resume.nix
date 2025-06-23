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
    name = "Containers";
    level = "Master";
    keywords = [
      "Podman"
      "Docker"
      "Docker Compose"
      "OCI"
      "Container registries"
    ];
  }
