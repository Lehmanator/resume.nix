{lib, ...}: {
  flake.data = {
    jsonresume.default = import ../src/jsonresume.nix;
    rendercv.default = import ../src/render-cv.nix;
  };
}
