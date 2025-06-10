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
    name = "Brazen";
    location = "Arlington, VA";
    position = "Software Engineering Intern";
    description = "Brazen is a company developing software for hosting video conferencing.";
    url = "https://brazenconnect.com";
    startDate = "2020-02-01";
    endDate = "2020-05-01";
    summary = "Developed features for video conferencing platform & chatbots for automated candidate onboarding.";
    highlights = [
      "Wrote Java code with Tensorflow API to integrate chatbot NLP agents with custom business logic."
      "Wrote frontend & backend code in Java for video conferencing web platform."
    ];
  }
