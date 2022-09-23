---
slug: heist-start
tags: [blog]
date: 2021-05-10
---

[Heist](https://github.com/snapframework/heist) is an "*xhtml-based templating engine, allowing Haskell functions to be bound to XML tags.*" and is suitable for use as a HTML templating #[[Haskell]] [library](https://vrom911.github.io/blog/html-libraries) where we need to care about using on-disk file templates rather a type-safe DSL. I found [its library documentation](http://snapframework.com/docs/tutorials/heist#heist-programming) somewhat lacking in regards to just getting started, so here's a quick howto.

The most simple use of `heist` library is a two-stage process. 

## Load templates

We *interpret* the templates here (but in your application you might want to compile them instead). `H.HeistState Identity` is the type we should keep track of in our application state.

```haskell
import qualified Heist as H
import qualified Heist.Interpreted as HI

loadHeistTemplates 
  :: MonadIO m => FilePath -> m (Either [String] (H.HeistState Identity))
loadHeistTemplates templateDir = do
  let heistCfg :: H.HeistConfig Identity =
        H.emptyHeistConfig
          & H.hcNamespace .~ ""
          & H.hcTemplateLocations .~ [H.loadTemplates templateDir]
  liftIO $ H.initHeist heistCfg
```

## Render templates

This is the part where we render HTML with a given context (what heist calls "splices").

```haskell
import qualified Text.Blaze.Renderer.XmlHtml as RX

renderHeistTemplate 
  :: ByteString -> Either [String] (H.HeistState Identity) -> LByteString
renderHeistTemplate name etmpl =
  either error id . runExcept $ do
    heist <-
      hoistEither . first (unlines . fmap toText) $ etmpl
    let 
      heistWithCtx = 
        heist 
          & HI.bindString "markdown-title" "Hello world"
          & HI.bindSplice "markdown-html" $ RX.renderHtml ...
    (builder, _mimeType) <-
      tryJust "Unable to render" $
        runIdentity $ HI.renderTemplate heistWithCtx name
    pure $ toLazyByteString builder
```

## External links

- https://github.com/srid/heist-extra (useful in particular for [[Ema]] apps)
