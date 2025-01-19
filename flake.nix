{
  nixConfig = {
    extra-substituters = "https://cache.garnix.io";
    extra-trusted-public-keys = "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=";
  };

  inputs = {
    emanote.url = "github:srid/emanote/idiomorph";
    nixpkgs.follows = "emanote/nixpkgs";
    flake-parts.follows = "emanote/flake-parts";
  };

  outputs = inputs@{ self, flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports = [ inputs.emanote.flakeModule ];
      perSystem = { self', pkgs, system, ... }: {
        emanote.sites."srid" = {
          layers = [{ path = ./.; pathString = "./."; }];
          port = 9801;
          prettyUrls = true;
        };
        apps.default.program = self'.apps.srid.program;
        packages.default = pkgs.symlinkJoin {
          name = "srid-static-site";
          paths = [ self'.packages.srid ];
          postBuild = ''
            cp -rv ${self}/.well-known $out/
          '';
        };
        devShells.default = pkgs.mkShell {
          buildInputs = [ pkgs.nixpkgs-fmt ];
        };
      };
    };
}
