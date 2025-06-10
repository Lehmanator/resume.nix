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
    name = "Web Development";
    level = "Master";
    keywords = [
      "HTML"
      "CSS"
      "Javascript"
      "Typescript"
      "Node.js"
      "React.js"
      "Webpack.js"
      "Babel.js"
      "Django"
      "Python"
      "NGINX"
    ];
  }
