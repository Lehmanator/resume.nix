{...} @ args:
{
  name = "resume.nix";
  description = "Nix flake project to build & deploy my personal resume using jsonresume.";
  type = "application";
  entity = "self";
  roles = ["developer"];
  startDate = "2024-01-24";
  url = "https://resume.samlehman.dev";
  # url = "https://codeberg.org/Lehmanator/resume.nix";
  highlights = [
    "Reproducible environment that pulls locked dependencies to build artifacts for my resume."
    "Builds an static webpage and PDF of my resume."
    "Automatically deploys successfully built artifacts to GitHub Pages using GitHub Actions."
    "Development shell with automatic installations of dependencies needed to hack on, build, and deploy my resume."
  ];
  keywords = [
    "Nix"
    "GitHub"
    "GitHub Pages"
    "GitHub Actions"
    "DevOps"
    "Node.js"
    "static site"
    "reproducible builds"
    "declarative"
    "CI / CD"
  ];
}
// args
