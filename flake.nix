{
  description = "XMage, dockerized";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/default";
    flake-parts.url = "github:hercules-ci/flake-parts";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      imports = [ inputs.treefmt-nix.flakeModule ];

      perSystem =
        { pkgs, ... }:
        {
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              docker
              dprint
              nixfmt
              shellcheck
              temurin-bin-17
              xmage
            ];
          };

          treefmt.programs = {
            actionlint.enable = true;
            dockerfmt.enable = true;
            nixfmt.enable = true;
            shellcheck.enable = true;
          };
        };
    };
}
