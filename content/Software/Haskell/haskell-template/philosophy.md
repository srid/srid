---
slug: haskell-template/philosophy
---

# Philosophy

## Use opinionated base tools

I originally created [[haskell-template]] to serve as the base template for my Haskell [[Projects]]. As such, I wanted it to support by default include the following:

- [[Relude]] (because `Prelude` is dangerous)
- [[haskell-language-server]] (because IDE integration from the get-go is invaluable)
- [[hlint]]
- [[treefmt]] (to keep the project tree autoformatted)
  - `fourmolu`[^ormolu] for Haskell
  - `nixpkgs-fmt` for Nix

[^ormolu]: I used to use `ormolu` but switched to `fourmolu` because ormolu is annoying in some cases (like it [throwing away multiline haddock comments](https://github.com/tweag/ormolu/issues/641))

## If it is not used in every repo, do not add it to the template

Things like tests are not in the repo, because I do not use it in every project created off this repo. Instead, a workflow like "How to add tests" should be documented. The same goes for documentation, which normally would use [[Emanote]].

## Keep [[Nix]] as simple as possible

I wish to keep all the Nix code (`flake.nix`) as small and simple as possible. This is why much of the Nix is delegated to [[haskell-flake]]. Consequently, it also becomes easier for the user to do some Nix-based Haskell workflows.