---
slug: ema-0.8
tags: [blog/ema]
date: 2022-08-07
---

:::{.page-note}
**tldr**: Announcing a rewrite of [[Ema]] (a static site generator in [[Haskell]] with hot reload destined to develop an unique kind of apps) with support for generic route encoders and composability.
:::

Today I'd like announce version 0.8 of [[Ema]]. This version is nearly a total rewrite,[^pr] aimed at improving Ema towards two ends:

[^pr]: [The PR](https://github.com/EmaApps/ema-template/pull/22) spawned commits over nearly 7 months of intermitten work with feedback and contributions from others.

1. **Generic routes**: automatically derive route encoders and decoders using generics 
1. **Composability**: combine multiple Ema sites to produce a new top-level site.

This post will give a rough overview of the new features, but checkout [the official tutorial](https://ema.srid.ca/tutorial) if you are new to Ema. 

## Generic routes

Until Ema 0.6, you have had to manually write route encoders and decoders. This is not only a tedious task, but also an error-prone process. Ema 0.8 introduces the `IsRoute` typeclass that can be generically derived in an inductive manner. A simple `TemplateHaskell` based API is also provided. What this means is that you can define your routes simply as follows and get encoders and decoders for free:

```haskell
data Route 
  = Route_Index -- /index.html
  | Route_About -- /about.html
  deriving stock (Show, Eq, Generic)

deriveGeneric ''Route 
deriveIsRoute ''Route [t|'[]|]
```

The TH function `deriveIsRoute` will create the `IsRoute` instance for `Route`, which in turn provides a `routePrism` method that returns, effectively, an [`optics-core` `Prism'` type](https://hackage.haskell.org/package/optics-core-0.4.1/docs/Optics-Prism.html#t:Prism-39-)--specifically, `Prism' FilePath Route`. This prism can be used to both encode and decode routes to and from the associated file paths.

### `DerivingVia`

TemplateHaskell is not strictly required, as you can alternatively use `DerivingVia` (via `GenericRoute`), though it is slightly more verbose:

```haskell
import Generic.SOP qualified as SOP

data Route 
  = Route_Index
  | Route_About
  deriving stock (Show, Eq, Generic)
  deriving anyclass (SOP.Generic, SOP.HasDatatypeInfo)
  deriving (HasSubRoutes, HasSubModels, IsRoute) via (GenericRoute Route '[])
```

The TH approach, however, has better error messages due to use of standalone deriving.

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

`GenericRoute` is designed in a way as to delegate the generic logic into two different type classes: `HasSubRoutes` and `HasSubModels`. This enables customizability of generic behaviour.

The first of these, `HasSubRoutes`, enables deriving the encoding and decoding behaviour of individual route constructors "via" their isomorphic (in generic representation) types. Let's consider the typical way to derive `IsRoute` for `BlogRoute` above:

```haskell
-- Let us assume that this is the top-level route in our site.
data BlogRoute
  = BlogRoute_Index
  | BlogRoute_Post Slug
  deriving stock (Show, Eq, Generic)

deriveGeneric ''BlogRoute 
deriveIsRoute ''BlogRoute [t|[]|]
```

Generic deriving here generates encoder and decoder such that `BlogPost_Post "foo"` maps to `/post/foo.html`. That is, the "folder prefix" is determined from the constructor name's suffix (`_Post`). This behaviour can be customized using the `WithSubRoutes` option to `GenericRoute` thus controlling the semantics of `HasSubModels`:

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

Now, `BlogPost_Post "foo"` maps to `/blog/foo.html`; note the distinction between `/blog` and `/post` prefix. You can also drop the prefix entirely by using `WithSubRoutes [FileRoute "index.html", Slug]`. Ema provides `FileRoute` and `FolderRoute` (which have an `IsRoute` instance), but nothing should you stop from writing your own representation types; the only requirement is that they have an isomorphic generic representation and the target type has an `IsRoute` instance.

### Route isomorphism checks

If your route prism is unlawful (they fail to satisfy the `Prism'` laws), Ema will check this at runtime. This is useful when you want to derive `IsRoute` manually. On the other hand, it is impossible to create unlawful prisms when using only generic deriving (assuming no custom `WithSubRoutes` encoding).

## Composability

Another key feature of Ema 0.8 is that multiple Ema apps can be combined to produce a new top-level site. [[Emanote]], a note-publishing system, is an Ema app. Say, you want to create a personal website using Ema, but want to delegate publishing of your notes to Emanote. You can combine both your Ema app and the Emanote managed site into a single site, by definining a top-level route like this:

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

Alternatively, you may create a top-level ADT instead (this has its own pros and cons):

```haskell
data TopRoute
  = TopRoute_MyApp Route 
  | TopRoute_Notes Emanote.SiteRoute

deriveGeneric ''TopRoute 
deriveIsRoute ''TopRoute [t|
  '[ WithSubRoutes 
     [ Route -- Override this to drop the /myapp prefix.
     , FolderRoute "notes" Emanote.SiteRoute
     ]
   ]
  |]
``` 

Now, your notes are served at path `/notes` with the rest of the site served from `/`.

You can view the full code for this pattern [here](https://github.com/srid/emanima/pull/2). See the "Multi" and "MultiRoute" [examples](https://github.com/EmaApps/ema/tree/master/src/Ema/Example) in Ema source tree.


## `Dynamic` instead of `LVar`

This release also introduces the `Dynamic` type to represent type-varying model values. `Dynamic`'s compose better than LVar's. The [unionmount](https://github.com/srid/unionmount) library, which [[Emanote]] uses, has also been updated to be `Dynamic`-friendly.

## Real-world example

See https://github.com/fpindia/fpindia-site for a real-world example that uses Ema 0.8 (the jobs data is [managed using `Dynamic`](https://github.com/fpindia/fpindia-site/pull/24)). There are more [here](https://ema.srid.ca/examples).

## Credits

I greatly appreciate feedback and contributions from the following people in enabling this release:

- [Lucas Vreis](https://github.com/lucasvreis), for actually [using](https://github.com/lucasvreis/abacateiro) the development branch (`multisite`) of Ema as it is being developed and thereby influencing much of the design behind generic deriving of routes.
- [Riuga Bachi](https://github.com/RiugaBachi), for [contributing](https://github.com/EmaApps/ema/pulls?q=author%3ARiugaBachi+) TemplateHaskell support, better compiler error messages, etc.
- [Iceland_jack](https://stackoverflow.com/users/165806/iceland-jack), [dfeuer](https://stackoverflow.com/users/1477667/dfeuer), [K. A. Buhr](https://stackoverflow.com/users/7203016/k-a-buhr) and others for answering my Haskell questions on Stackoverflow.

For further information, see the official documentation: https://ema.srid.ca.