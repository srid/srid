---
slug: haskell-template
---

# `haskell-template`

`haskell-template` (<https://github.com/srid/haskell-template>) is a template Git repository for ready-made, fully reproducible and friendly #[[Haskell]] development using #[[Nix]] with full IDE support in [[VSCode]] (and other editors). See [[philosophy]] for what's (and why it is) included.

- [[haskell-template/start]]
- HOWTO
  - Common Haskell workflows
    - To run **hoogle** with project dependencies, run `bin/hoogle`
    - To run the project **ghci** (aka. 'cabal repl'), run `bin/repl`.
    - To run the project executable with auto-recompkle via **ghcid**, run `bin/run`
    - [[haskell-template/add-tests]]
    - Dependency management
      - [ ] How to add a package (cabal and nix)

        Add the package to the .cabal file, and re-run `nix develop` (and restart [[VSCode]]).
      - [ ] How to override a package (nix)

        Use [this tutorial](https://tek.brick.do/how-to-override-dependency-versions-when-building-a-haskell-project-with-nix-K3VXJd8mEKO7) when setting the the `overrides` option of [[haskell-flake]]
  - Common Nix workflows
    - `nix build`: Build the nix package.
    - `nix run .`: Run the program via Nix.
      - `nix run github:srid/haskell-template`: Run the program via Nix remotely.
    - `nix profile install github:srid/haskell-template`: Install the program via Nix.
    - `nix --option sandbox false build .#check -L`: Run flake checks
  - [ ] [Switching to `direnv`](https://github.com/srid/haskell-template/issues/3)
  - CI
    - [[haskell-template/garnix]]

## Discussion

Comments? Ideas? Post them [on GitHub](https://github.com/srid/haskell-template/discussions).