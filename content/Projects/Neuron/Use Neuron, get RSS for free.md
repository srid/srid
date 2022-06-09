---
date: 2021-02-28
slug: neuron-feed
tags: [micro/neuron]
---

[Atom, not RSS](https://en.wikipedia.org/wiki/Web_feed) - but you get the idea. 

Instead of writing your own static site generator, and write code to laboriously generate RSS feeds (which are all useful exercise in learning) - why not use [[Neuron]][^tmpl], and add the following to your, say, `blog.md` and call it a day?

```yaml
---
feed:
  count: 5
---
```

That is all it takes to generate an atom feed, `blog.xml`, that will aggregate all of your blog posts linked from `blog.md`. See neuron's documentation on the [Web feeds plugin](https://neuron.zettel.page/feed) for details.

~~On this site, you have three examples: add any of these -- `[[Blog]], [[Microblog]], or [[Neuron]]` -- to your feed reader, if you want to keep yourself abreast of new content in those zettels.~~ (This website has migrated to [[Emanote]] as of June 2021)

[^tmpl]: See https://github.com/srid/neuron-template for a template to instantly get started with little fuss (requires a GitHub account).
