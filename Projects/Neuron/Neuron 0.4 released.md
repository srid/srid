---
slug: neuron-v04
tags: [blog/neuron]
date: 2020-05-13
---

#[[Neuron]] is a Zettelkasten note taking app I originally open sourced about two months ago (see [[Announcing Neuron - Zettelkasten in Haskell]]). Recently a new version was [released](https://github.com/srid/neuron/releases/tag/0.4.0.0) incorporating some interesting improvements, many of them were inspired by invaluable user feedback.

## Highlights

### Editor support (emacs) 

You can use felko's [zettel-mode](https://github.com/felko/neuron-mode) to edit your notes in Emacs. It allows the following nifty features:

* Open a zettel by title
* Create a new zettel
* Insert a link to another zettel (by title)
* Automatically expanad zettel links in the buffer to display the title next to it

That last feature in particular is my favourite. It is very useful to know what a particular link is linking to it when you are editing a zettel. Here's a screencast demonstrating it (click to play the video):

[![emacsDemo]](https://asciinema.org/a/329911)

[emacsDemo]: https://asciinema.org/a/329911.svg

### Simplified linking syntax [\#59](https://github.com/srid/neuron/issues/59)

Several users requested that the syntax for linking to zettels be simplified. To that extent, Neuron now supports the following style of links:

```markdown
* This is a link to a zettel: [[[5b963b1c]]]. 
* It will automatically expand to the Zettel title 
  that is linked in the web interface.
```

In short, to link to a zettel whose ID is "5b963b1c", you only need to wrap it inside angle brackets. We are not using any *special* syntax here; this is what is known as [Autolinks](https://spec.commonmark.org/0.16/#autolinks) in the commomark spec. Neuron simply leverages existing linking syntax to allow you to link to zettels; and the Neuron renderer can automtically fill in the zettel title, and other metadata, during rendering stage.

### Random hash IDs [\#151](https://github.com/srid/neuron/issues/151)

By default neuron now uses random hash when creating a new zettel. The (previous) date ID format is still available, but just not as the default. This was done mainly to avoid conflicts when multiple people are working on a shared Zettelkasten.

### Full backlinks [\#34](https://github.com/srid/neuron/issues/34)

Each zettel now displays all zettels linking to it (regardless of it being a Folgezettel link).

### Themes [\#89](https://github.com/srid/neuron/pull/89)

The web interface can now be configured to use a particular color theme. See [the documentation](https://neuron.zettel.page/2014601.html) for a list of available themes.

### In-browser search [\#90](https://github.com/srid/neuron/pull/90)

The web interface includes a search page that users can use to search their zettelkasten by title or tag. This feature was contributed by a user.

### Hierarchical tags [\#115](https://github.com/srid/neuron/pull/115)

You can now use the notion of "tag tree" in your Zettelkasten. It works like this. If you tag a zettel with say `math/calculus/definition`, then you have it linked automatically in any other zettel that queries for `math/**`, `math/calculus/*` or `math/calculus/definition`. It works with globbing pattern, allowing interesting possibilities like having a Zettel link to all definition zettels using `**/definition`. This feature was also an user contribution, and is documented [here](https://neuron.zettel.page/2011506.html).

### Querying Zettelkasten in JSON 

There is a `neuron query` command which you can use to query the entire Zettelkasten and have its results returned in JSON format. The emacs mode (discussed above) uses this feature extensively.

```sh
# Here, we are querying all zettels by the tag "nomenclature"
$ neuron query -t nomenclature | jq -r .result[].title
Zig-zag gaze
Hierarchy of well-being
Concealed Morality
$ 
```

## Roadmap, and formats other than Markdown

The development version (not 0.4) supports Pandoc for Markdown. What this means is that it *is* possible to support other markup formats like reST, [[Org Mode]], Asciidoc, etc. All they must have in common is a syntax (like the markdown autolinks) that will produce the appropriate Pandoc AST node for neuron to process. 

[Comments at lobste.rs](https://lobste.rs/s/kydg6q/neuron_0_4_zettelkasten_note_management)
