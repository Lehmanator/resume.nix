{...}: {
  perSystem = {config, ...}: {
    apps.default = config.apps.pdf2;

    # TODO: Init resume, convert to nix
    apps.init = {
      type = "app";
      program = config.packages.jsonresume-script-init;
    };

    apps.image = {
      type = "app";
      program = config.packages.jsonresume-script-builder-image-png;
    };

    apps.pdf = {
      type = "app";
      program = config.packages.jsonresume-script-builder-pdf;
    };

    apps.pdf2 = {
      type = "app";
      program = config.packages.jsonresume-script-builder-pdf-weasyprint;
    };

    apps.view-json = {
      type = "app";
      program = config.packages.jsonresume-script-view-json;
    };
    apps.view-html = {
      type = "app";
      program = config.packages.jsonresume-script-view-html;
    };
  };
}
