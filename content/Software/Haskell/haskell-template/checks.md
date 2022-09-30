---
slug: haskell-template/checks
---

# Flake checks for Haskell

[[haskell-flake]] provides a builtin list of flake checks that you can manually enable:

- [[haskell-language-server]] check (`hlsCheck.enable = true`): Tests that HLS continues to work with the project.
- [[hlint]] check (`hlintCheck.enable = true`): Tests that the project does not have any hlint warnings.

## `nix flake check` and IFD

You cannot use `nix flake check` (unless your `systems` list is singular) [due to IFD](https://nixos.wiki/wiki/Haskell#IFD_and_Haskell). You can work around this by using the [check-flake](https://github.com/srid/check-flake) `flake-parts` module; make the following changes to your `flake.nix`:

1. Add `check-flake.url = "github:srid/check-flake";` to "inputs"
2. Add `inputs.check-flake.flakeModule` to "imports"

Now you can run the following command[^sandbox] to run all flake checks locally for the current system:

```sh
nix --option sandbox false build .#check -L
```

[^sandbox]: sandbox is being disabled because of [an issue](https://github.com/srid/haskell-flake/issues/21) with [[haskell-language-server]].