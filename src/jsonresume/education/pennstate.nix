{
  hide ? ["score" "endDate"],
  overrides ? {},
  ...
} @ args: let
  base = builtins.removeAttrs args ["hide" "overrides"];
  merge = a: builtins.removeAttrs (base // a // {} // overrides) hide;
in
  merge
  {
    institution = "Penn State University";
    url = "https://psu.edu";
    area = "Computer Science";
    startDate = "2014-08-20";
  }
