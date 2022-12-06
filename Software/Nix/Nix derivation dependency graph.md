---
slug: remove-references-to
date: 2020-06-18
---

# Nix derivation dependency graph

I recently had to debug [a problem](https://web.archive.org/web/20210125202157/https://github.com/srid/neuron/issues/193) wherein a #[[Haskell]] binary created using Nix was created with a runtime dependency on the entire GHC ecosystem (despite using `justStaticExecutables`). This investigation led to identifying Cabal’s `Paths_*` module autogeneration as the root cause.

The following commands came in handy when investigating the problem, which was fixed (as a workaround) using `remove-references-to`.

## Useful commands

- Get the dependency tree:
    
    ```sh-session
    nix-store -q --tree result
    ```
    
- Ask “why” as to a particular dependency:
    
    ```sh-session
    nix why-depends -a ./result \
     /nix/store/bicv5nnibqg0qsqyjvb3nw01447yms0j-shake-0.18.5-data
    ```
    
- Remove reference to a dependency manually using [`remove-references-to`](https://web.archive.org/web/20210125202157/https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/remove-references-to/default.nix).

## Cleaning up after Cabal using `remove-references-to`

Some examples:

- [from nixpkgs](https://web.archive.org/web/20210125202157/https://github.com/NixOS/nixpkgs/blob/46405e7952c4b41ca0ba9c670fe9a84e8a5b3554/pkgs/development/tools/pandoc/default.nix#L13-L28)
- [neuron’s PR](https://web.archive.org/web/20210125202157/https://github.com/srid/neuron/pull/240/files)
- [Emanote's PR](https://github.com/EmaApps/emanote/pull/392)
