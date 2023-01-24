{
  nixConfig.extra-substituters = "https://cache.srid.ca";
  nixConfig.extra-trusted-public-keys = "cache.srid.ca:8sQkbPrOIoXktIwI0OucQBXod2e9fDjjoEZWn8OXbdo=";

  inputs = {
    emanote.url = "github:srid/emanote/stork-leak";
    nixpkgs.follows = "emanote/nixpkgs";
    flake-parts.follows = "emanote/flake-parts";
  };

  outputs = inputs@{ self, flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports = [ inputs.emanote.flakeModule ];
      perSystem = { self', pkgs, system, ... }: {
        emanote.sites."default" = {
          layers = [ ./. ];
          layersString = [ "./." ];
          port = 9801;
          prettyUrls = true;
        };
        devShells.default = pkgs.mkShell {
          buildInputs = [ pkgs.nixpkgs-fmt ];
        };
      };
    };
}
