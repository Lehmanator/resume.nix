{ buildPythonPackage
, python3
, ruff
, rendercv
, #, loadPyproject
  #, fetchPypi
  lib
,
}:
let
  drvAttrs = (buildPythonPackage { python = python3; }) // {
    version = "unstable-2024-05-16";
    src = rendercv.outPath;
    pythonRelaxDeps = true;
  };
in
python3.pkgs.buildPythonApplication (drvAttrs // {
  inherit ruff;
  meta = {
    description = "LaTeX CV generator from a YAML/JSON input file";
    homepage = "https://github.com/sinaatalay/rendercv";
    license = lib.licenses.mit;
    #maintainers = [lib.maintainers.Lehmanator];
    mainProgram = "rendercv";
  };
})
#  let
#    src-cfg = inputs.rendercv.outPath + "/pyproject.toml";
#    cfg-orig = lib.importTOML src-cfg;
#    cfg-over = { build-system.requires = [ "hatchling>=1.21.1" ]; };
#    project = inputs.pyproject-nix.lib.project.loadPyproject {
#      pyproject = lib.recursiveUpdate cfg-orig cfg-over;
#      projectRoot = inputs.rendercv.outPath;
#    };
#    drvAttrs = (project.renderers.buildPythonPackage {
#      python = pkgs.python3.override {
#        packageOverrides = self: super: {
#          hatchling = super.hatchling.overridePythonAttrs (old: rec {
#            version = "1.21.1";
#            src = pkgs.fetchPypi {
#              inherit (old) pname;
#              inherit version;
#              hash =
#                "sha256-u6RARToiTn1EeEV/oujYw2M3Zbr6Apdaa1O5v5F5gLw=";
#            };
#          });
#        };
#      };
#    }) // {
#      version = "unstable-2024-02024-02-01T155-14";
#      src = inputs.rendercv.outPath;
#      pythonRelaxDeps = true;
#    };
#  in
#  pkgs.python3.pkgs.buildPythonApplication
#    (drvAttrs // { inherit (pkgs) ruff; });
