{
  lib,
  buildNpmPackage,
}:
buildNpmPackage rec {
  pname = "jsonresume-to-rendercv";
  version = "1.0.13";
  src = ./.;
  dontNpmBuild = true;
  npmDepsHash = "sha256-1V3pHmsaJYzjGyfidWzDsJ+FRPIfhVnejG5AT8HvGhU=";

  meta = {
    # https://github.com/jsonresume/jsonresume.org/tree/master/packages/converters/jsonresume-to-rendercv
    homepage = meta.repo.package or "https://jsonresume.org";
    repo = {
      package = "https://github.com/jsonresume/jsonresume.org/tree/${meta.repo.branch}/${meta.repo.path}";
      parent = "https://github.com/jsonresume/jsonresume.org";
      path = "packages/converters/jsonresume-to-rendercv";
      branch = "master";
    };
    license = lib.licenses.mit;
    mainProgram = "@jsonresume/${pname}";
    maintainers = [];
    description = "Convert resume data from JSON Resume to RenderCV format.";
    longDescription = ''
      # jsonresume-to-rendercv

      `jsonresume-to-rendercv` is a JavaScript program to convert resume data.
         from: the [`JSON Resume`](${meta.homepage}) schema represented in JSON format.
         into: the [`RenderCV`](https://rendercv.com) schema represented in YAML format.

      ## Usage

      ```bash
        $ jsonresume-to-rendercv <INPUT>.json
      ```

      ## Notes

      Changes from original repo:

      - Updated `package-lock.json` to remove the relative directory dependencies on the original surrounding monorepo.*
      - Changed arg parsing to allow specifying an output path.
      - Changed the default output filename from `resume.yaml` to `rendercv.yaml`

      ## To-Do:

      - [ ] Reproduce this script in Nix library function: `lib.jsonresume.toRenderCv`
      - [ ] Handle stdin/stdout for piping data in/out
      - [ ] Add more social platforms

    '';
  };
}
