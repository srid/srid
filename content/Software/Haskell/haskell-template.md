---
slug: haskell-template
---

# `haskell-template`

`haskell-template` (<https://github.com/srid/haskell-template>) is a template Git repository for ready-made, fully reproducible and friendly #[[Haskell]] development using #[[Nix]]. It comes with full IDE support in [[VSCode]] (and other editors with LSP support). See [[philosophy]] for what's (and why it is) included.

## Rationale

The goal of `haskell-template` is to enable anyone to get started with [[Haskell]] development without much fanfare (thanks to [[Nix]]). I also use `haskell-template` to bootstrap all of my new Haskell projects. See [[haskell-template/start]] to get started.

## Documentation

- [[haskell-template/start]]
- HOWTO
  - `nix develop`: The nix shell is your friend; inside it, you will have the full Haskell development environment (cabal, ghc, ghci, [[haskell-language-server]], cabal-fmt, hlint, etc.).
  - Common Haskell workflows
    - Useful Scripts

      | Script       | Description                                             |
      | ------------ | ------------------------------------------------------- |
      | `bin/run`    | Run the main executable via [[ghcid]] (auto-recompiles) |
      | `bin/repl`   | Run `cabal repl`                                        |
      | `bin/hoogle` | Run `hoogle` (Documentation for dependencies)           |

    - [[haskell-template/add-tests]]
    - Dependency management
      - [ ] How to add a Haskell package dependency

        Add the package to the .cabal file, and re-run `nix develop` (and restart [[VSCode]]). If the package is unavailable, you will have to override it (see next point).
      - [ ] How to override a Haskell package in [[Nix]]

        Use [this tutorial](https://tek.brick.do/how-to-override-dependency-versions-when-building-a-haskell-project-with-nix-K3VXJd8mEKO7) when setting the the `overrides` option of [[haskell-flake]]
  - Common Nix workflows
    - `nix build`: Build the nix package.
    - `nix run .`: Run the program via Nix.
      - `nix run github:srid/haskell-template`: Run the program via Nix remotely.
    - `nix profile install github:srid/haskell-template`: Install the program via Nix.
    - `nix --option sandbox false build .#check -L`: Run flake checks[^ifd]
  - [ ] [Switching to `direnv`](https://github.com/srid/haskell-template/issues/3)
  - CI
    - [[haskell-template/garnix]]

[^ifd]: We cannot use `nix flake check` [due to IFD](https://nixos.wiki/wiki/Haskell#IFD_and_Haskell). And sandbox is being disabled because of [an issue](https://github.com/srid/haskell-flake/issues/21) with [[haskell-language-server]].

## Discussion

Comments? Ideas? Post them [on GitHub](https://github.com/srid/haskell-template/discussions).