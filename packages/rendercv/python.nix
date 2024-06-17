{ python3, fetchPypi, }:
python3.override {
  packageOverrides = self: super: {
    hatchling = super.hatchling.overridePythonAttrs (old: rec {
      version = "1.21.1";
      src = fetchPypi {
        inherit (old) pname;
        inherit version;
        hash = "sha256-u6RARToiTn1EeEV/oujYw2M3Zbr6Apdaa1O5v5F5gLw=";
      };
    });
  };
}
#python = pkgs.python3.override {
#  packageOverrides = self: super: {
#    hatchling = super.hatchling.overridePythonAttrs (old: rec {
#      version = "1.21.1";
#      src = pkgs.fetchPypi {
#        inherit (old) pname;
#        inherit version;
#        hash =
#          "sha256-u6RARToiTn1EeEV/oujYw2M3Zbr6Apdaa1O5v5F5gLw=";
#      };
#    });
#  };
#};
