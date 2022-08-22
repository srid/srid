---
slug: obelisk-tutorial
tags: [blog, nojs]
date: 2020-05-08
---

In this article, I'll describe how to get a full-stack Haskell application up and running. In particular, the app will render user-entered Markdown text in real-time (the final version is hosted at <https://commonmark.srid.ca>). Notably, our app will use Haskell even on the frontend. This is made possible by the [GHCJS](https://github.com/ghcjs/ghcjs) compiler, that compiles Haskell code to JavaScript. 

We will not work directly with GHCJS, however, and instead will use the [[Reflex-FRP]] library, through the excellent #[[Obelisk]] full-stack framework.

## Create an Obelisk project

First and foremost, make sure you have [Obelisk installed](https://github.com/obsidiansystems/obelisk#installing-obelisk), and then follow along.

Obelisk includes a command called `ob` that can be used to initialize a project. We will also use git to keep track of changes:

```bash
mkdir MarkdownPreview
cd ./MarkdownPreview
# Create an Obelisk project
ob init
# Add to git
git init
git add .
git commit -m "first commit"
```

This gives us a project layout with three Haskell packages: `backend`, `common` and `frontend`. As the names indicate, `frontend` contains the Haskell code that ultimate gets compiled to JavaScript. The `common` package however contains code that is shared between the backend and the frontend. This is extremely useful for type sharing, which is impossible with something like [[Elm]] or PureScript (without explicit conversion).

```sh
backend
cabal.project
common
config
default.nix
frontend
shell.nix
static
```

You will notice that Obelisk uses [[Nix]] to build your project. The command `ob run` (described below) will abstract over the Nix stuff, including any GHCi handling, so you do not have to deal directly with Nix except for overriding dependencies.

## Running hello world

Now, it is time to run our app. 

```sh
ob run
```

This command may take a while to finish the very first time it is run, as it would need to download packages from the Nix caches. At the end you would expect to see: `Frontend running on http://localhost:8000/`. Your obelisk app will be accessible at that URL.

### Interlude: `ob run` reloads your code

So what does this `ob run` command do? Think of it as `stack run` or `cabal run` - but it also recompiles changed sources and reloads application. `ob run` uses [ghcid](https://github.com/ndmitchell/ghcid) underneath, in combination with custom `ghci` config to specify the modules to reload.

There is also `ob repl` which gives you a GHCi repl for your project. As well as `ob hoogle` providing a local Hoogle server for project and its dependencies.

## Add `commonmark-hs` dependency

Our application will use the Pure Haskell Markdown parser [commonmark-hs](https://github.com/jgm/commonmark-hs), which is written by the author of Pandoc, who intends to [migrate Pandoc over to it](https://github.com/jgm/commonmark-hs/issues/1#issuecomment-395802118) eventually. 

We will also use the latest version from Git, instead of Hackage. Some [Nix-fu](https://nixos.org/nix/) is helpful at this stage. But the main thing you need to know, in order to add a custom Haskell dependency, is the following general workflow:

* Clone the git repo under a subdirectory
* "Pack" it using `ob thunk`
* Load it in `default.nix` using `hackGet`

As briefly as possible, you would do this for commonmark-hs as follows:

```sh
# Get the source
git clone https://github.com/jgm/commonmark-hs.git dep/commonmark-hs
...
# Pack it
ob thunk pack dep/commonmark-hs
...
```

Next, edit your `default.nix` and:

* Add `hackGet` and `pkgs` as arguments to the `project` if they don't already exist
* Use the packed thunk by calling `hackGet`
* The git rep contains multiple Haskell packages; use `commonmark` and `commonmark-extensions`

Here's how your `default.nix` should look:

```nix
project ./. ({ pkgs, hackGet, ... }: {
  packages = let 
    commonmarkSrc = hackGet ./dep/commonmark-hs;
  in {
    commonmark = commonmarkSrc + "/commonmark";
    commonmark-extensions = commonmarkSrc + "/commonmark-extensions";
  };
  ...
})
```

If you run `ob run` at this point, it may complain about further missing dependencies. Let's override each of them:

```sh
git clone https://github.com/jgm/emojis.git dep/emojis
ob thunk pack dep/emojis
```

Go back to `default.nix`, and add this new dependency to the `packages` attribute:

```nix
    ...
    emojis = hackGet ./dep/emojis;
```

As we will be using commonmark directly in the frontend, go ahead and add these to `frontend.cabal` (under the library stanza):

```haskell
-- frontend/frontend.cabal
               ...
               , commonmark
               , commonmark-extensions
  
```

Restart `ob run`, which should build the the new dependency before starting our app.

### Interlude: What is an Obelisk thunk?

If you are familiar with [Haskell overrides in Nix](https://www.srid.ca/1948201.html#overriding-dependencies), then think of the obelisk thunk mechanism as an abstraction on top. A "packed" thunk is essentially similar to Nix's `fetchGit` in that you specify the exact source revision of the dependency to use. 

But a thunk can also be "unpacked", using `ob thunk unpack`, which -- in addition to unpacking it as a git clone -- has the effect of adding it to `ob run` and `ob repl` sessions. For example, you could unpack the above commonmark thunk using `ob thunk unpack dep/commonmark-hs` and restart `ob run`. Now, when you hack on `./dep/commonmark-hs` and change its Haskell sources, `ob run` will automatically reload the app using the modified commonmark-hs. See the Obelisk [ChangeLog](https://github.com/obsidiansystems/obelisk/blob/master/ChangeLog.md#v0500---2020-02-07) for details.

## Let's add a textbox

If you are unfamiliar with Reflex, checkout [the official guide](https://reflex-frp.org/get-started). All our frontend code is defined in the `frontend/src/Frontend.hs` file. With `ob run` running by side, open that module and try changing a few things, like the title - and the app should update. Let's add a textbox element where the user would write their Markdown text.

Somewhere in `_frontend_body`, add the following:

```haskell
markdownText :: Dynamic t T.Text <-
  fmap value $ textAreaElement $
    def
    & initialAttributes .~ ("style" =: "width:50%;height:15em;")
```

`markdownText` is a reflex Dynamic that holds the user-entered text.

## Parse Markdown

Now it is time to actually use the commonmark library. Let's import it:

```haskell
import qualified Commonmark as CM

renderMarkdown :: T.Text -> Either CM.ParseError (CM.Html ())
renderMarkdown =
  CM.commonmark "markdown"
```

The `renderMarkdown` function will parse our Markdown and return the HTML representation of it. Calling `show` on the Right value gets us the raw HTML.

## Render to HTML

Finally let's plug everything together. We want to parse and render the resulting HTML every time the user changes the textbox. Reflex's Dynamic automatically updates, so let's use that.

```haskell
result <- eitherDyn $ fmap renderMarkdown markdownText
dyn_ $ ffor result $ \case
  Left err ->
    dyn_ $ ffor err $ \_ -> text "Parse error"
  Right htmlVal ->
    prerender_ blank $ void $ elDynHtml' "div" $ T.pack . show <$> htmlVal

```

That's all it takes! Now as you type the Markdown text, its live preview will automatically update next to the textbox.

You can even hack on commonmark-hs (see the Obelisk thunk interlude above), and have `ob run` automatically reload when the library sources change. This is extremely handy if you want to play with the internals of the Markdown parser and see its live result in the browser.

## Further resources

* Source code for this app on Github: <https://github.com/srid/MarkdownPreview>

* Fully built version of it running at: <https://commonmark.srid.ca/>
