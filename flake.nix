{
  nixConfig = {
    extra-substituters = "https://cache.nixos.asia/oss";
    extra-trusted-public-keys = "oss:KO872wNJkCDgmGN3xy9dT89WAhvv13EiKncTtHDItVU=";
  };

  inputs = {
    emanote.url = "github:srid/emanote";
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
          extraConfig.template.urlStrategy = "pretty";
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
