# This file was generated by nvfetcher, please do not modify it manually.
{
  fetchgit,
  fetchurl,
  fetchFromGitHub,
  dockerTools,
}: {
  mkdocs-macros-plugin = {
    pname = "mkdocs-macros-plugin";
    version = "1.0.5";
    src = fetchurl {
      url = "https://pypi.org/packages/source/m/mkdocs-macros-plugin/mkdocs-macros-plugin-1.0.5.tar.gz";
      sha256 = "sha256-/jSNdfAckR82K22ZjFez2FtQWHbd5p25JPLFEsOVwyg=";
    };
  };
  rendercv = {
    pname = "rendercv";
    version = "1.8";
    src = fetchurl {
      url = "https://pypi.org/packages/source/r/rendercv/rendercv-1.8.tar.gz";
      sha256 = "sha256-IIwxS3KvqJjHBqDoTk1En7gHq8a9KXMYQX+3qZJAi38=";
    };
  };
}
