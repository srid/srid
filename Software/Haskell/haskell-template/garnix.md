---
slug: haskell-template/garnix
---

# Adding Garnix CI

[[haskell-template]] already uses Github Actions for CI, but you may also use [Garnix](https://garnix.io/). Garnix is a Nix based hosted CI service that integrates well with GitHub. Compared to Github Actions, Garnix CI jobs run faster and finally you get a free Nix cache as a result (no need to manually push to cachix). 

You may use the following `garnix.yaml` to enable both Linux and macOS builds:

```yaml
builds:
  include:
    - "*.aarch64-darwin.*"
    - "*.x86_64-linux.*"
  exclude:
    # https://github.com/srid/haskell-flake/issues/21
    - "checks.*.main-hls"
```
