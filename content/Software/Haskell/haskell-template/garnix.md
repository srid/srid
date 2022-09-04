---
slug: haskell-template/garnix
---

# Adding Garnix CI

[[haskell-template]] already uses Github Actions for CI, but if you wish to use [Garnix](https://garnix.io/) -- a Nix based hosted CI service that integrates well with GitHub -- instead, you may provide a `garnix.yaml` like the below:

```yaml
builds:
  include:
    - "packages.x86_64-linux.*"
    - "packages.aarch64-darwin.*"
    - "checks.x86_64-linux.*"
    - "checks.aarch64-darwin.*"
    - "devShells.x86_64-linux.default"
    - "devShells.aarch64-darwin.default"
  exclude:
    # https://github.com/srid/haskell-flake/issues/21
    - "checks.*.default-hls"
    - "packages.*.check"
```