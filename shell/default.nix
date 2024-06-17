{ inputs, config, ... }:
let
  flakeConfig = config;
in
{
  imports = [
    # TODO: Move to ./parts/devshell.nix?
    inputs.devshell.flakeModule

    # devShell for jsonresume
    ./jsonresume.nix

    # devShell for rendercv
    ./rendercv.nix
  ];

  # Set default devshell to jsonresume (for now)
  # perSystem = { config, ... }: {
  #   devshells.default = config.devshells.jsonresume;
  # };
}
