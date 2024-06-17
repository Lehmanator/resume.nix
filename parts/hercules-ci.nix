{inputs, ...}: {
  imports = [inputs.hercules-ci-effects.flakeModule];
  hercules-ci = {
    flake-update = {
      autoMergeMethod = "merge";
      flakes."." = {commitSummary = "flake.lock: update";};
    };
    github-pages = {
      branch = "main";
      check.enable = true;
      pushJob = "default";
      settings = {
        contents = inputs.self.packages.x86_64-linux.jsonresume-html;
        message = "Update GitHub Pages";
      };
    };
    github-releases.files = {
      label = "resume.pdf";
      path = inputs.self.packages.x86_64-linux.jsonresume-pdf + "/resume.pdf";
    };
  };
  perSystem = {
    config,
    lib,
    pkgs,
    ...
  }: {
    hercules-ci.github-pages.settings = {
      contents = config.packages.jsonresume-html;
      git.update.branch = "doc";
      message = "Update GitHub Pages";
    };
  };
}
