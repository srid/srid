---
slug: fsharp-exploration
tags: [blog/fsharp, nojs]
date: 2021-04-02
---

# A brief F\# exploration

I have been writing full-stack web apps in [[Haskell]] using functional reactive programming ([[Reflex-FRP]]) for 3 years now. Curiosity stuck me as to find out what the [FP](https://en.wikipedia.org/wiki/Functional_programming) languages other than Haskell had to offer in this area.

## My critieria were:

- Must be a functional programming language
- Should compile to JS or Wasm (cf. [[No JavaScript]])
- Must run natively on backend without nodeJS (rules out the likes of [[PureScript]])

Haskell's GHCJS (esp. when used with [[Obelisk]]) satisfies all of this, but there is one pain-point: the future of GHCJS (which has [not been updated](https://github.com/ghcjs/ghcjs) in a year) and Reflex seems to be in the hands of *one small company*, Obsidian Systems.

That **lead me to F\#**, a hybrid FP language ("hybrid" because it supports OOP, which is essential to integrate with the rest of the .NET ecosystem). I've documented my learnings [here](https://srid.github.io/learning-fsharp/).

## What I found impressive:

- Full access to the entire **.NET** ecosystem of libraries and frameworks (which is larger than that of Haskell).
- [.NET 5.0](https://devblogs.microsoft.com/dotnet/announcing-net-5-0/#unified-platform-vision) ecosystem is a pleasure to work with (and it works well on Linux with VSCode); and you can create cross-platform apps [more straightforwardly](https://github.com/srid/neuron/pull/586) than in Haskell, including on mobile devices.
    - If I were to start developing [[Neuron]] today, I would certainly consider F# (but see below).
- Microsoft has a great **full-stack** web development story; and they support WebAssembly ([`Blazor`](https://srid.github.io/learning-fsharp/Blazor)), including a framework for real-time communication (`SignalR`).
    - In F#, [Bolero](https://fsbolero.io/) today is the go-to framework to make use of the above technology.
- I find it reassuring that I can **rely on Microsoft** to advance the full-stack web development more than one small consultancy (Obsidian Systems) with less than transparent open source development in the Haskell land. 
    - That said, I have some hopes that Tweag's [Asterius](https://github.com/tweag/asterius) catches up, and the community is encouraged to proliferate a whole new ecosystem of full-stack development tools in Haskell not necessarily tied to Reflex.

## Some things are better in the Haskell ecosystem, though. 

- Fast development reload workflow works super well in Haskell, thanks to [[ghcid]]. In .NET, you have `dotnet watch` - but that recompiles the whole project on every change leading to annoying delay[^net6]; it made me [switch back](https://github.com/srid/Feather/issues/10) to using Haskell for DSL-based static sites, while live-reload is essential to get quick feedback on things like CSS changes.
- Having to work with OOP-based .NET libraries (written in C\#) can be an annoyance from a pure-FP perspective, though that can be dealt with by wrapping these libraries in a functional layer, and then using that in the F# program.
- Overriding dependencies to use a fork in *straightforward* manner is virtually impossible. You have to create a local Nuget repo containing the binary of your overriden dependency. Whereas in Haskell world, one can easily use [[Nix]] to use a Git repo ([[Neuron]] [does this](https://github.com/srid/neuron/tree/master/dep)) as a package dependency.[^paket]

[^net6]: .NET 6.0 will [address this](https://devblogs.microsoft.com/aspnet/asp-net-core-updates-in-net-6-preview-3/#initial-net-hot-reload-support) at least for Blazor projects.
[^paket]: No, [Paket's Git feature](https://fsprojects.github.io/Paket/git-dependencies.html) does *not* support this.

**F# will continue to remain in my toolbox**. If the aforementioned downsides are addressed in some way, I might just pick it for some of the next projects over Haskell, which is still my go-to language today.

## See also

- My F# notes: https://srid.github.io/learning-fsharp/
- Disussion on [Hacker News](https://news.ycombinator.com/item?id=26739501) & [Lobsters](https://lobste.rs/s/odejpy/brief_f_exploration)
