---
slug: haskell-release-process
tags: [blog]
date: 2020-04-08
---

Just a note to myself as to the steps I normally follow when releasing a #[[Haskell]] library to [Hackage](http://hackage.haskell.org/).

## Release steps

1. Create a `release-x.y` branch
2. Finalize ChangeLog.md
3. Run `nix develop -c cabal haddock` and sanity check the haddocks
4. Commit all changes, and push a release PR.
5. Generated sdist using `cabal sdist` (if using flakes, run `nix run nixpkgs#cabal-install -- sdist`)
6. Run `cabal upload [--publish] <path/to/sdist>` to upload the sdist. Ignore `--publish` if you want to preview it first.
7. Publish Haddocks manually (optional, if Hackage doesn't do it automatically)
    1. Run `cabal haddock --haddock-for-hackage` to generated haddocks for hackage.
    1. Run `cabal upload -d --publish $PATH_TO_TARBALL` to update haddocks on the release.
10. Squash merge the PR.
11. [Draft a new release](https://github.com/srid/rib/releases) on Github. Copy paste the change log. This will automatically create and push the new git tag.

### Post-release

1. Increment cabal version in .cabal file
2. Plan, as first task, updating of nixpkgs and package dependencies.

## Open questions

- [ ] Research a tool that automates much of the release process; cf. https://twitter.com/domenkozar/status/1744333116687184030
