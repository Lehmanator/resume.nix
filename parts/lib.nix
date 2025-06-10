{
  inputs,
  config,
  lib,
  ...
} @ top: {
  flake.lib = inputs.haumea.lib.load {
    src = ../lib;
    transformer = inputs.haumea.lib.transformers.liftDefault;
    inputs = builtins.removeAttrs top ["self"];
  };
}
