{
  description = "A flake for my profile website project";

  inputs = {
    self.submodules = true;
    systems.url = "github:nix-systems/default";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    {
      self,
      systems,
      nixpkgs,
      treefmt-nix,
    }:
    let
      eachSystem = nixpkgs.lib.genAttrs (import systems);
      pkgs = eachSystem (system: nixpkgs.legacyPackages.${system});

      treefmtEval = eachSystem (
        system:
        treefmt-nix.lib.evalModule pkgs.${system} {
          projectRootFile = "flake.nix";
          programs = {
            nixfmt.enable = true;
            nixf-diagnose.enable = true;
          };
        }
      );
    in
    {
      checks = eachSystem (system: {
        formatting = treefmtEval.${system}.config.build.check self;
      });
      formatter = eachSystem (system: treefmtEval.${system}.config.build.wrapper);
      devShells = eachSystem (system: {
        default = pkgs.${system}.mkShellNoCC {
          nativeBuildInputs = [ pkgs.${system}.bun ];
          shellHook = ''
            if [ -d node_modules ]; then
              bun install
            fi

            bun run fmt
            bun run lint
          '';
        };
      });
    };
}
