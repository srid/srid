---
slug: purescript-nix
tags: [blog, nojs]
date: 2020-04-16
---

My #[[Haskell]] app [[Neuron]] recently received a [contribution](https://github.com/srid/neuron/pull/90) that added support for the very useful client-side search feature. JavaScript was used to implement it; however after having gotten used to merrily creating [[Reflex-FRP]]-based web apps (frontend and backend both in Haskell), writing raw JavaScript had very little appeal to me, which left me with the following options:

* GHCJS: Reflex
* GHCJS: Miso
* PureScript

One appeal of PureScript is that it is comparitively lightweight to install, develop and use (which is how I'd describe neuron itself).

## Creating a Hello World project

If you already use [[Nix]] (or [[NixOS]]), getting a quick feel for PureScript is just a
matter of running:

```bash
nix-shell -p purescript -p spago
```

[Spago](https://github.com/purescript/spago) is the PureScript package manager.
It uses [[Dhall]] for configuration, which is exactly what Neuron uses as well. Once
you are in the nix-shell we shall create a new PureScript project:

```bash
mkdir /tmp/app1 && cd /tmp/app1
spago init
```

The project will have minimal files:

```bash
$ tree
.
├── packages.dhall
├── spago.dhall
├── src
│   └── Main.purs
└── test
    └── Main.purs

2 directories, 4 files
```

and very basic PureScript code:
```haskell
-- src/Main.purs
module Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)

main :: Effect Unit
main = do
  log "🍝"
```

To build the final JavaScript "executable", run `spago bundle-app`; it will
generate a `index.js` for use from HTML.

```bash
$ spago bundle-app
[info] Installation complete.
[info] Build succeeded.
[info] Bundle succeeded and output file to index.js

$ wc -l -c index.js
 29 792 index.js
```

That's basically it. Very easy to install and use!

## ghcid of PureScript

Not using any fancy IDE, I find [[ghcid]] to be
critical to my Haskell development workflow; its fast compile-reload cycle
facilitates a very delightful development experience. I wanted to have this
with PureScript. Fortunately, such a tool exists ---
[pscid](https://github.com/kritzcreek/pscid). pscid is available in Nix, so you
may simply restart that nix-shell as:

```bash
nix-shell -p purescript -p spago -p pscid
```

Then visit the project directory, and run:

```bash
pscid
```

Now modify `src/Main.hs` and watch it recompile on the fly. When you are done
with your changes, you would run `spago bundle-app` at the end to build the
final JavaScript.

## "So how do I use `getElementById`?"

Haskellers are familiar with Hoogle. In PureScript ecosystem, that is called
[Pursuit](https://pursuit.purescript.org/). I wanted to know, as part of [adding
PureScript to neuron](https://github.com/srid/neuron/pull/106), how to use the
famous `getElementById` function in PureScript; and pursuit [came to
help](https://pursuit.purescript.org/search?q=getElementById).

```haskell
getElementById :: String -> NonElementParentNode -> Effect (Maybe Element)
```

Hmm, what is "`NonElementParentNode`"? This function is from the
`purescript-web-dom` library, which uses the [DOM
spec](https://dom.spec.whatwg.org/) which does indeed
[document](https://dom.spec.whatwg.org/#interface-nonelementparentnode) this
second argument, although it is implicitly provided by `this` in JavaScript. In
PureScript you would pass it explicitly. HTML Document is one of the values it
can take:


```haskell
main = do
  doc <- map toNonElementParentNode $ document =<< window
  myElem <- getElementById "someId" doc
```

**EDIT:** The lack of documentation around things like this is something I
noticed immediately in the PureScript ecosystem; a lobste.rs user [explains it here](https://lobste.rs/s/wa99yt/coming_purescript_from_haskell_reflex#c_faof1j).

## Logging to console

The project template already uses the `log` function to log strings to browser
console. But how do we log an arbitrary PureScript object, like the DOM element?
Using
[`traceM`](https://pursuit.purescript.org/packages/purescript-debug/4.0.0/docs/Debug.Trace#v:traceM):

```haskell
import Debug.Trace (traceM)
main = do
  doc <- map toNonElementParentNode $ document =<< window
  myElem <- getElementById "someId" doc
  traceM myElem
```

And that's all it takes to get the initial feel for what it is like to develop
PureScript as a Haskeller who comes from the world of Nix and GHCJS.

## External links

- [Getting Started with PureScript](https://github.com/purescript/documentation/blob/master/guides/Getting-Started.md) (official guide)
