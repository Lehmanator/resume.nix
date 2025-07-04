{
  extraHighlights ? [],
  hide ? [],
  overrides ? {},
  ...
} @ args: let
  base = builtins.removeAttrs args ["extraHighlights" "hide" "overrides"];
  merge = a: builtins.removeAttrs (base // a // {highlights = a.highlights or [] ++ extraHighlights;} // overrides) hide;
in
  merge
  {
    name = "General Electric: Transportation";
    location = "Lawrence Park, PA";
    description = "Locomotive manufacturer";
    position = "Electrical Integration - Software Engineering Intern";
    url = "https://ge.com";
    startDate = "2018-06-01";
    endDate = "2018-09-01";
    summary = "GE Transportation (now Wabtec) is a global leader in locomotive manufacturing.";
    highlights = [
      "Wrote C program to validate configurations to control locomotive hardware."
      "Wrote Python program to perform mechanical analysis on locomotive wireframe structures to identify & diagnose possible points of failure."
      "Wrote Visual Basic for Applications (VBA) code to integrate Python & C programs with Microsoft Excel spreadsheets used by engineers."
      "Built graphical Python application to compare, diff, and validate options in locomotive configuration files."
    ];
  }
