---
slug: haskell-new-project
date: 2020-11-16
tags: [blog]
---

**Update (May 31, 2021)**: If you use Flakes, try [[haskell-template]].

---

I create new #[[Haskell]] libraries and applications using #[[Nix]], along with IDE support in #[[VSCode]] as follows.

First, install [nix-thunk](https://github.com/obsidiansystems/nix-thunk) (alternatively, you may use niv or flakes).

```bash
# Initialize project layout using cabal
mkdir mypkg && cd mypkg
# Note: Pass --lib, --exe or --libandexe as appropriate
nix-shell -p cabal-install -p ghc --run \
  "cabal init --cabal-version=3.0 -m -l BSD3 --lib -p mypkg"

# Add to git
git init && git add . && git commit -m "Initial commit"

# Remove, or update, version constraint on base to match compiler
vim *.cabal  # and remove version constraint on `base`

# Pin nixpkgs, etc
# You might want to pass --rev, using the value from status.nixos.org
nix-thunk create \
  https://github.com/nixos/nixpkgs.git dep/nixpkgs
nix-thunk create \
  https://github.com/hercules-ci/gitignore.nix.git dep/gitignoresrc

# Write template default.nix
cat << EOF > default.nix
{ pkgs ? import ./dep/nixpkgs {} }:
let 
  inherit (import ./dep/gitignoresrc { inherit (pkgs) lib; }) gitignoreSource;
in 
  pkgs.haskellPackages.developPackage {
    name = "mypkg";
    root = gitignoreSource ./.;
    modifier = drv:
      pkgs.haskell.lib.addBuildTools drv (with pkgs.haskellPackages;
        [ cabal-install
          cabal-fmt
          ghcid
          ormolu
          haskell-language-server
        ]);
  }
EOF

# Test your changes
nix-build
nix-shell --run 'cabal-fmt -i *.cabal'  # Formats your cabal file
nix-shell --run 'ghcid -T :main'

# Create .gitignore and commit
echo -e "dist-newstyle\nresult" > .gitignore
git add . && git commit -m "Nixify"
```

To enable IDE support,

- Copy [.vscode template](https://github.com/srid/reflex-stone/tree/master/.vscode) to `./.vscode` (note: settings.json should point to default.nix instead of shell.nix)
- Add the [appropriate hie.yaml](https://github.com/haskell/haskell-language-server#configuring-your-project-build)
- Test your configuration by running `nix-shell --run haskell-language-server` (it should succeed with module-level reports)
- Open the folder in VSCode and follow the instructions

Other things you might want to do:

- Use [[Relude]] as Prelude
- Enable some `default-extensions`
- Enable [sensible warnings][warn] in `ghc-options`

[warn]: https://kowainik.github.io/posts/2019-02-06-style-guide#ghc-options

## Alternatives

- Using Flakes? See [this blog post](https://serokell.io/blog/practical-nix-flakes) from Serokell, and try out the [[haskell-template]] Git template.
