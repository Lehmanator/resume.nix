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
    startDate = "2017-06-01";
    endDate = "2017-09-01";
    summary = "GE Transportation (now Wabtec) is a global leader in locomotive manufacturing.";
    highlights = [
      "Wrote C program to parse failure logs to identify causes of locomotive failure."
      "Wrote DXL script to push batches of locomotive configuration updates and pull diagnostic data."
      "Added OAuth2 authentication to numerous internal tools to use company-wide single-sign-on (SSO) to prevent unauthorized access to sensitive data."
    ];
  }
