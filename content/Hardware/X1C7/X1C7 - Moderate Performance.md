---
slug: x1c7-perf
---

#[[X1C7]]'s performance is reasonably good for both home-office and coffee-shop use. 

The carbon does suffer a bit with heavy workloads, such as some long compilation (eg: GHCJS) tasks, IDE heavylifting (haskell-language-server) or when using complex (bloated) web apps. Some of those, such as Nix compilation, can be offloaded to my [[P71]] workstation at home (via manual ssh, [[VSCode]] [remote ssh][vsr] or [distributed](https://nixos.wiki/wiki/Distributed_build) build).

Per the pareto principle, the carbon is still a delight to use, although one must be aware of this compromise in performance, and not to mention memory limit (16G max RAM).

Performance and portability tradeoff wise, the [[X1E]] is positioned in between [[X1C7]] and [[P71]].

[vsr]: https://code.visualstudio.com/docs/remote/ssh
