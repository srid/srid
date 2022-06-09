---
slug: rust-nix
tags: [blog/rust/learning]
date: 2021-04-08
---

While most would be satisfied with `rustup`, I wanted to use #[[Nix]] for writing any new project in #[[Rust]] - especially as I see the value of Nix, and I already use [[NixOS]]. It took a bit of digging to evaluate the existing options, and come up with a template Nix setup for new projects. 

:::{.ui .message}
All the code in this post is part of [rust-nix-template](https://github.com/srid/rust-nix-template) which you can use to bootstrap your Rust project using the Nix approach detailed here. Thanks to  [Alexander Bantyev](https://old.reddit.com/r/rust/comments/mmbfnj/nixifying_a_rust_project/) for the pointers.
:::

Let's support [Flakes](https://nixos.wiki/wiki/Flakes) from the get-go. To nixify your Rust project, add the following files to your project *and* set the `name` and `description` fields in `flake.nix` file appropriately. Then run `nix develop` to get a nix shell (`nix-shell` also works), or `nix run` to run the app (`nix-build` also works).

Some points to note:

- We are using the `oxalica/rust-overlay` overlay to get Rust and friends, because this gives a more recent version than what's available in nixpkgs.
- `kolloch/crate2nix:tools.nix` is like `callCabal2nix` in Haskell but for Rust projects
- `numtide/flake-utils` provides Flake utility functions, notably `eachDefaultSystem`
- `edolstra/flake-compat` enables us to use our `flake.nix` to automatically support legacy Nix builders: `nix-shell` and `nix-build`.
- The `.vscode` folder contains all the settings necessary to open the project with full IDE support in #[[VSCode]], for Rust and Nix (including auto format).

## `flake.nix`

```nix
# This file is pretty general, and you can adapt it in your project replacing
# only `name` and `description` below.

{
  description = "...";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
    crate2nix = {
      url = "github:kolloch/crate2nix";
      flake = false;
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, utils, rust-overlay, crate2nix, ... }:
    let
      name = "my-app";
    in
    utils.lib.eachDefaultSystem
      (system:
        let
          # Imports
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              rust-overlay.overlay
              (self: super: {
                # Because rust-overlay bundles multiple rust packages into one
                # derivation, specify that mega-bundle here, so that crate2nix
                # will use them automatically.
                rustc = self.rust-bin.stable.latest.default;
                cargo = self.rust-bin.stable.latest.default;
              })
            ];
          };
          inherit (import "${crate2nix}/tools.nix" { inherit pkgs; })
            generatedCargoNix;

          # Create the cargo2nix project
          project = pkgs.callPackage
            (generatedCargoNix {
              inherit name;
              src = ./.;
            })
            {
              # Individual crate overrides go here
              # Example: https://github.com/balsoft/simple-osd-daemons/blob/6f85144934c0c1382c7a4d3a2bbb80106776e270/flake.nix#L28-L50
              defaultCrateOverrides = pkgs.defaultCrateOverrides // {
                # The app crate itself is overriden here. Typically we
                # configure non-Rust dependencies (see below) here.
                ${name} = oldAttrs: {
                  inherit buildInputs nativeBuildInputs;
                } // buildEnvVars;
              };
            };

          # Configuration for the non-Rust dependencies
          buildInputs = with pkgs; [ openssl.dev ];
          nativeBuildInputs = with pkgs; [ rustc cargo pkgconfig nixpkgs-fmt ];
          buildEnvVars = {
            PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
          };
        in
        rec {
          packages.${name} = project.rootCrate.build;

          # `nix build`
          defaultPackage = packages.${name};

          # `nix run`
          apps.${name} = utils.lib.mkApp {
            inherit name;
            drv = packages.${name};
          };
          defaultApp = apps.${name};

          # `nix develop`
          devShell = pkgs.mkShell
            {
              inherit buildInputs nativeBuildInputs;
              RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
            } // buildEnvVars;
        }
      );
}
```

## `shell.nix`

```nix
(import
  (
    let
      lock = builtins.fromJSON (builtins.readFile ./flake.lock);
    in
    fetchTarball {
      url = "https://github.com/edolstra/flake-compat/archive/${lock.nodes.flake-compat.locked.rev}.tar.gz";
      sha256 = lock.nodes.flake-compat.locked.narHash;
    }
  )
  {
    src = ./.;
  }).shellNix
```

## `default.nix`

```nix
(import
  (
    let
      lock = builtins.fromJSON (builtins.readFile ./flake.lock);
    in
    fetchTarball {
      url = "https://github.com/edolstra/flake-compat/archive/${lock.nodes.flake-compat.locked.rev}.tar.gz";
      sha256 = lock.nodes.flake-compat.locked.narHash;
    }
  )
  {
    src = ./.;
  }).defaultNix
```

## `.vscode/`

Add a `.vscode/` folder containing these files,

### `.vscode/extensions.json`

```json
{
    "recommendations": [
        "matklad.rust-analyzer",
        "jnoortheen.nix-ide"
    ]
}
```

### `.vscode/settings.json`

```json
{
    "nixEnvSelector.nixFile": "${workspaceRoot}/shell.nix",
    "editor.formatOnSave": true
}
```

All these files are available in [this project](https://github.com/srid/bouncy).
