{
  nixConfig = {
    extra-substituters = "https://cache.nixos.asia/oss";
    extra-trusted-public-keys = "oss:KO872wNJkCDgmGN3xy9dT89WAhvv13EiKncTtHDItVU=";
  };

  inputs = {
    emanote.url = "github:srid/emanote";
    nixpkgs.follows = "emanote/nixpkgs";
    flake-parts.follows = "emanote/flake-parts";
    wrangler.url = "github:emrldnix/wrangler";
  };

  outputs = inputs@{ self, flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports = [ inputs.emanote.flakeModule ];
      perSystem = { self', inputs', pkgs, lib, system, ... }: {
        emanote.sites."srid" = {
          layers = [{ 
            path = pkgs.lib.cleanSourceWith {
              src = ./.;
              filter = path: type:
                let
                  baseName = baseNameOf path;
                  isTopLevel = dirOf path == toString ./.;
                in
                  !(lib.hasSuffix "flake.nix" path) &&
                  !(lib.hasSuffix "flake.lock" path) &&
                  !(isTopLevel && lib.hasPrefix "." baseName) &&
                  !(isTopLevel && baseName == "README.md");
            };
            pathString = "./."; 
          }];
          port = 9801;
          extraConfig.template.urlStrategy = "pretty";
        };
        apps.default.program = self'.apps.srid.program;
        packages = {
          default = pkgs.symlinkJoin {
            name = "srid-static-site";
            paths = [ self'.packages.srid ];
            postBuild = ''
              cp -rv ${self}/.well-known $out/
            '';
          };
          deploy = pkgs.writeShellApplication {
            name = "deploy";
            runtimeInputs = [
              inputs'.wrangler.packages.default
            ];
            text = ''
              # First, `wrangler login`
              wrangler pages deploy ${self'.packages.default} --project-name srid
            '';
          };
        };
        devShells.default = pkgs.mkShell {
          buildInputs = [ pkgs.nixpkgs-fmt ];
        };
      };
    };
}
