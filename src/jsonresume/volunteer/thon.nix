{
  hide ? [],
  overrides ? {},
  extraHighlights ? [],
  ...
} @ args: let
  base = builtins.removeAttrs args ["extraHighlights" "hide" "overrides"];
  merge = a: builtins.removeAttrs (base // a // {highlights = a.highlights or [] ++ extraHighlights;} // overrides) hide;
in
  merge
  {
    organization = "THON";
    position = "Technology Captain";
    url = "https://think.thon.org";
    startDate = "2018-09-01";
    endDate = "2019-04-01";
    summary = "THON is a student-run non-profit organization raising money for pediatric cancer research and the children affected by it. The THON Technology committee develops software to facilitate volunteer work and manage the annual dance marathon event.";
    highlights = [
      "Containerized developer environment to speed up onboarding new volunteer developers."
      "Containerized production webserver to make production environment reproducible."
      "Used Python & Django to create informational webpages to update volunteers on latest events & news."
      "Used Python & Django to create forms to collect and process information from volunteers."
    ];
  }
