---
slug: ema-0.8
tags: [blog/ema]
date: 2022-08-07
---

:::{.page-note}
**tldr**: Announcing a rewrite of [[Ema]] (a static site generator in Haskell with hot reload destined to develop an unique kind of apps) with support for generic route encoders and composability.
:::

Today I'd like announce version 0.8 of [[Ema]]. This version is nearly a total rewrite,[^pr] aimed at improving Ema towards two ends:

[^pr] [The PR](https://github.com/EmaApps/ema-template/pull/22) spawned commits over nearly 7 months of intermitten work with feedback from various people.

1. **Composability**: merge multiple Ema sites to produce a new top-level sites.
2. **Generic routes**: automatically derive route encoders and decoders using generics 

## Generic routes

In Ema 0.6, you have to manually write route encoders and decoders. This is not only a tedious task, but also an error-prone process. Ema 0.8 introduces the `IsRoute` typeclass that can be generically derived. A simple `TemplateHaskell` based API is also provided. What this means is that you can define your routes as follows:

```haskell
data Route 
  = Route_Index
  | Route_About
  deriving stock (Show, Eq, Generic)

deriveGeneric ''Route 
deriveIsRoute ''Route [t|[]|]
```

TH function `deriveIsRoute` will create the `IsRoute` instance for `Route`, which in turn provides a `routePrism` method that returns, effectively, an `optics-core` `Prism'` type--specifically, `Prism' FilePath Route`. This prism can be used to both encode and decode routes.

### `DerivingVia`

TemplateHaskell is not strictly required, as you can alternatively use `DerivingVia`, though it is a bit more verbose:

```haskell
import Generic.SOP qualified as SOP

data Route 
  = Route_Index
  | Route_About
  deriving stock (Show, Eq, Generic)
  deriving anyclass (SOP.Generic, SOP.HasDatatypeInfo)
  deriving (HasSubRoutes, HasSubModels, IsRoute) via (GenericRoute Route '[])
```

### Sub-routes

ADTs are a natural fit to represent route types. Routes can also be nested. For example, here's the official example of a weblog:

```haskell
data Route
  = Route_Index
  | Route_About
  | Route_Contact
  | Route_Blog BlogRoute

data BlogRoute
  = BlogRoute_Index
  | BlogRoute_Post Slug

newtype Slug = Slug { unSlug :: String }
```

Here, `BlogRoute` is a sub-route of `Route`. Furthermore, `Slug` is a sub-route of `BlogRoute`. The generic deriving mechanism knows how to delegate encoding/decoding to sub-routes.

### Sub-route representation

To derive `IsRoute` generically via `GenericRoute` we must also derive a couple of utility classes: `HasSubRoutes` and `HasSubModels`. The first of these enables deriving the encoding and decoding behaviour "via" isomorphic (in generic representation) types. Let's consider typical way to derive `IsRoute` for `BlogRoute` above:

```haskell
data BlogRoute
  = BlogRoute_Index
  | BlogRoute_Post Slug
  deriving stock (Show, Eq, Generic)

deriveGeneric ''Route 
deriveIsRoute ''Route [t|[]|]
```

Generic deriving here generates encoder and decoder such that `BlogPost_Post "foo"` maps to `/post/foo.html`. That is, the "folder prefix" is determined from the constructor name's suffix (`_Post`). This behaviour can be customized using the `WithSubRoutes` option to `GenericRoute`:

```haskell
data BlogRoute
  = BlogRoute_Index
  | BlogRoute_Post Slug
  deriving stock (Show, Eq, Generic)

deriveGeneric ''Route 
deriveIsRoute ''Route [t|
  '[ WithSubRoutes 
     [ FileRoute "index.html"
     , FolderRoute "blog" Slug
     ]
   ]
  |]
```

Now, `BlogPost_Post "foo"` maps to `/blog/foo.html` (note the distinction between `/blog` and `/post` prefix). 

### Validity checks

If your route prism is unlawful, Ema will check this at runtime. This is useful when you want to derive `IsRoute` manually. On the other hand, it is impossible to create unlawful prisms when using generic deriving.

## Composability

Another key feature of Ema 0.8 is that multiple Ema apps can be combined to produce a new top-level site. [Emanote](https://emanote.srid.ca/), a note-publishing system, is an Ema app. Say, you want to create a personal website using Ema, but want to delegate publishing of your notes to Emanote. You can combine both your Ema app and the Emanote managed site into a single site, by definining a top-level route like this:

```haskell
import Emanote.Route.SiteRoute.Type qualified as Emanote

data Route = ...  -- My Ema app's route

type TopRoute =
    MultiRoute 
        '[ Route 
         , FolderRoute "notes" Emnote.SiteRoute
         ]

main = do 
  Ema.runSite @TopRoute ...
```

Now, your notes are served at path `/notes` with the rest of the site served from `/`.

You can view the full code for this pattern [here](https://github.com/srid/emanima/pull/2). See the "Multi" and "MultiRoute" [example](https://github.com/EmaApps/ema/tree/master/src/Ema/Example) for another way of doing this, using regular ADT.

## Credits

I greatly appreciate feedback and contributions from the following people in enabling this release:

- [Lucas Vreis](https://github.com/lucasvreis), for actually [using](https://github.com/lucasvreis/abacateiro) development version of Ema as it is being developed and thereby impacting much of the design behind generic deriving of routes.
- [Riuga Bachi](https://github.com/RiugaBachi), for [contributing](https://github.com/EmaApps/ema/pulls?q=author%3ARiugaBachi+) TemplateHaskell support, better compiler error messages, etc.
- [Iceland_jack](https://stackoverflow.com/users/165806/iceland-jack), [dfeuer](https://stackoverflow.com/users/1477667/dfeuer), [K. A. Buhr](https://stackoverflow.com/users/7203016/k-a-buhr) and others for answering my questions in Stackoverflow.
