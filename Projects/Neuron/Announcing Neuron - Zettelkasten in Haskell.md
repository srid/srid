---
slug: neuron-announce
tags: [blog/neuron]
date: 2020-03-09
---

**UPDATE \(2020-03-19\)**: See [neuron.zettel.page](https://neuron.zettel.page/) for up-to-date information on neuron.

Two weeks ago I learned of a note-taking method called **Zettelkasten**, which aims to be a superior alternative to traditional methods like outliners (think Workflowy or Dynalist) and mindmaps. In Zettelkasten, you create notes with *no pre-defined structure* ... yet, over-time a structure will emerge. This is because as you add new notes to the system, you would also be making connections between them. What happens is that a [directed graph](https://en.wikipedia.org/wiki/Directed_graph) organically evolves, producing a heterarchy (not hierarchy) of your notes. See [this article](https://writingcooperative.com/zettelkasten-how-one-german-scholar-was-so-freakishly-productive-997e4e0ca125) by David Clear for an excellent introduction to Zettelkasten.

I was very impressed by Zettelkasten enough to start using it right away. I choose to stick with plain-text format, rather than using a custom app like [Roam](https://roamresearch.com/) or [Zettlr](https://www.zettlr.com/). To that end, I began developing my own "viewer" for zettels in Haskell (using the [rib](https://github.com/srid/rib) static site generator). Eventually I rewrote my website (the one you are reading) to be based on the very same system. This gave me the opportunity to open source the common parts of the system, in the name of [**neuron**](https://github.com/srid/neuron).

I use #[[Neuron]] both for my private Zettelkasten, as well as the public site (this one). What follows below is summary of some of the capabilities neuron currently supports.

## Shorter Zettel ID

Each zettel has an unique ID, typically encoding the date and time that zettel was created. Neuron uses weekdays in IDs. Consider the following zettel ID: `2008306`. It is only 7 characters in length, but can uniquely identify a note taken in an adult's lifetime.

The first two letters, `20`, represent the year (and I'll have to live beyond age 135 to run out of space here!). The next two, `08`, represent the [week number](https://en.wikipedia.org/wiki/ISO_week_date) of the year. The subsequent letter, `3`, which can be anything from `1` to `7`, represents the week day. Finally, the last two letters represent the n'th note taken in that day (I don't envision writing more than 100 notes per day; but if I do, I can always upgrade to using alphabetic characters in this location).

The above example corresponds to the note file `2008306.md` on disk.

## Extended Markdown

I came up with the notion of a "zettel link" with its own special [URI](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier) protocol `z:/`. The goal is to allow zettels to link among each other without necessarily knowing anything about their exact location. Neuron has a custom [MMark extension](https://hackage.haskell.org/package/mmark-ext) that supports zettel links. Here's an example:

```markdown
This is a zettel file, which links to another zettel: [2008403](z:/)
```

The MMark extension will replace this with the actual link to the zettel, along with other information like title, as well as possibly date and time.

## Searching zettels

Neuron does not officially support this yet, but I have scripts put together using [fzf](https://github.com/junegunn/fzf), [ripgrep](https://github.com/BurntSushi/ripgrep) that will search zettel files by title (or even by content) before opening them. In neovim, I have bound [Ctrl+L](kbd:) to invoke this search to quickly access any of my zettels.

## Creating zettels

The "new" subcommand creates a zettel with the appropriately choosen zettel ID. I would run `nvim $(neuron new)` to start writing a new zettel right away, and then access any relevant zettels to forms connections between one another using the `z:/` link described above.

## Zettel Graph

This is my favourite feature. A zettelkasten is a directed graph, so I used Haskell's [algebraic-graphs](https://github.com/snowleopard/alga) library to explore doing fun things with it, which resulted in my discovery of the relevance of [`dfsForest`](https://hackage.haskell.org/package/algebraic-graphs-0.5/docs/Algebra-Graph-AdjacencyMap-Algorithm.html#v:dfsForest), which -- more or less -- gives us a forest (tree with multiple roots) of the graph. This then gets rendered as some sort of automatic "category tree". Remember how above we noted that there is no pre-defined structure, and yet one evolves organically? 

## See also

* [Zulip discussion](https://funprog.srid.ca/general/zettelkasten.html)
* [Comments on Lobste.rs](https://lobste.rs/s/iuqcbo/announcing_neuron_zettelkasten_haskell)
