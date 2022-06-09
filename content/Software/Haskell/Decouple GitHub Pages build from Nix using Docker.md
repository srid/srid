---
slug: nix-docker-ci-decouple
tags: [blog]
date: 2021-10-10
---

Projects like [[Ema]] enable creating your own static-site generator in [[Haskell]], while leveraging #[[Nix]] for reproducibility. The challenge with deploying your Haskell-based static site on [GitHub Pages], however, is the lack of Nix caching. Every time you update your site, the CI will run slowly due to having to:

- Download, and rebuild any Haskell dependencies overriden in the Nix file
- Rebuild the static site Haskell project itself

Now, if you are *scheduling* generation of site (presumably because the *input* to your site is fetched afresh from the internet), then the above steps will re-run needlessly. This can be avoided by **decoupling** the `build` and `generate` steps.

## The build step

The build step should run `nix-build`, effectively - and then use [Nix's docker infrastructure][nix-docker] to produce a Docker image out of it and push it to a remote (Docker Hub or GitHub's image registry).

[Example](https://github.com/srid/TheMotteDashboard/actions/runs/1226415802)

## The generate step

The generate step of the CI would then *use* the latest Docker image from the registry and simply "run" your project. There is no compilation whastoever involved here, so it completes instantly. 

[Example](https://github.com/srid/TheMotteDashboard/actions/runs/1266781482)

## Links

- First step illustration: [build.yaml](https://github.com/srid/TheMotteDashboard/blob/0cf1c6927253284cc51e65e1c4dd12b528690759/.github/workflows/build.yaml)
- Second step illustration: [cron.yaml](https://github.com/srid/TheMotteDashboard/blob/0cf1c6927253284cc51e65e1c4dd12b528690759/.github/workflows/cron.yml) (generate)

[nix-docker]: https://nix.dev/tutorials/building-and-running-docker-images
[GitHub Pages]: https://pages.github.com/