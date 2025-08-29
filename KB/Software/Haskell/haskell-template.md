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
    - Useful Scripts (defined via [just](https://just.systems/))

      | Script      | Description                                             |
      | ----------- | ------------------------------------------------------- |
      | `just run`  | Run the main executable via [[ghcid]] (auto-recompiles) |
      | `just repl` | Run `cabal repl` (gives you a `ghci` repl)              |
      | `just docs` | Run `hoogle` (Documentation server for packages in use) |

    - [Adding dependencies](https://haskell.flake.page/dependency) (or how to override them in Nix)
    - [[haskell-template/add-tests]]
  - Common Nix workflows
    - `nix build`: Build the nix package.
    - `nix run .`: Run the program via Nix.
      - `nix run github:srid/haskell-template`: Run the program via Nix remotely.
    - `nix profile install github:srid/haskell-template`: Install the program via Nix.
    - [[haskell-template/checks]]
  - Removing features from the template
    - [[remove-relude]]
  - [Switching to `direnv`](https://haskell.flake.page/direnv)
  - CI
    - [[haskell-template/garnix]]


## Discussion

Comments? Ideas? Post them [on GitHub](https://github.com/srid/haskell-template/discussions).

#[[Projects]]