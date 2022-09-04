---
slug: haskell-template
---

# `haskell-template`

`haskell-template` (<https://github.com/srid/haskell-template>) is a template Git repository for ready-made, fully reproducible and friendly #[[Haskell]] development using #[[Nix]] with full IDE support in [[VSCode]] (and other editors). See [[philosophy]] for what's (and why it is) included.

- [[haskell-template/start]]
- HOWTO
  - [[haskell-template/add-tests]]
  - Haskell stuff
    - [ ] bin/hoogle
    - [ ] bin/repl
  - Package management
    - [ ] How to add a package (cabal and nix)
    - [ ] How to override a package (nix)
  - More Nix stuff
    - `nix run`
    - [ ]  Run `nix --option sandbox false build .#check -L` to run the flake checks.
  - [ ] Switching to `direnv`
  - CI
    - [[haskell-template/garnix]]

## Discussion

Comments? Ideas? Post them [on GitHub](https://github.com/srid/haskell-template/discussions).