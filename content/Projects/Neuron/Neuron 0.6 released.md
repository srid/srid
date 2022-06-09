---
slug: neuron-v06
tags: [blog/neuron]
date:  2020-07-28
---

#[[Neuron]] is a note-taking tool based on [Zettelkasten](https://neuron.zettel.page/2011401.html), that aims to be [future-proof](https://neuron.zettel.page/6f0f0bcc.html). Version [0.6](https://github.com/srid/neuron/releases/tag/0.6.0.0) just got released; its major highlight is that neuron is now based on the **Pandoc** AST. This allows us to support any format supported by [Pandoc](https://pandoc.org/). Experimental **org-mode** support is [already in](https://github.com/srid/neuron/issues/313), to begin with.

## Better Markdown

Previous versions of neuron used the [mmark](https://hackage.haskell.org/package/mmark) parser which advertises itself as being "strict". This prevented certain links from working as they caused the parser to fail. In version 0.6, I switched over to use [commonmark-hs](https://github.com/jgm/commonmark-hs), which is the Haskell implementation of the [**CommonMark** specification](https://commonmark.org/), written by the same author of Pandoc. Another reason for switching is that commonmark-hs and its extensions can be compiled to JavaScript via GHCJS[^ob], which is useful when reusing the Haskell code with the web app (see below).

[^ob]: See [[Obelisk tutorial, Markdown preview with Reflex]] for a description of the development workflow involving writing Haskell on the frontend.

The commonmark-hs parser includes [a bunch of nifty **extensions**](https://github.com/jgm/commonmark-hs/tree/master/commonmark-extensions) that are all made available in neuron. 

In addition, you can style your Markdown notes using supported Semantic UI classes ([see here](https://github.com/srid/neuron/issues/176)), as well as use raw HTML if necessary.

## Uplink Tree

I find arbitrary graph views of Zettelkasten software to be rarely useful. Neuron on the other hand displays what is known as a "[uplink tree](https://neuron.zettel.page/uplink-tree.html)" in each note view, which represents the *subset* (inasmuch as "uplink" is a type of "backlink") of the backlink graph for that note. In Zettelkasten-speak, we talk of a note "branching" to another. The uplink tree displays all notes "branching" to the note being viewed. 

Uplink Trees are similar to navigation panel or category tree, except that the heterarchy is built organically over time based on how the notes are linked (see [Folgezettel Heterarchy](https://neuron.zettel.page/folgezettel-heterarchy.html)). In the screenshot below, you are viewing the uplink tree of the note titled "Type safe static assets". Notice how this note has multiple parents (that "branch of" to that note). See [Linking](https://neuron.zettel.page/linking.html) in the neuron manual.

![](https://ipfs.io/ipfs/Qmap6GViyXmgVsvLWJzGEXeeHhuS4VLi8rDe8JFseU3nWR?filename=2020%20neuron%20uplinktree.png)

## Vim

In addition to [Emacs](https://neuron.zettel.page/4a6b25f1.html), there is now a Vim extension for neuron. See [neuron.vim](https://github.com/ihsanturk/neuron.vim) by ihsan. Just like the Emacs extension, it supports "virtual titles" in neovim, where the title of a linked note is displayed next to the link ID, as you can see from the screenshot below.

![](https://ipfs.io/ipfs/QmRA6WeuRrK7BMDdkxYc5X1VraBTUBBGpNbu8j1Kz1sv2y?filename=2020%20neuron-vim.png)

## Improved CLI query

The `neuron query` command can be used to query your Zettelkasten and get JSON output. `neuron query --id <ID>` gets you the metadata of a zettel note, whereas `neuron query --graph` gets the entire graph. For an example of what you can do with the later, check out [neuron-autoindex](https://github.com/b0o/neuron-extras) by Maddison Hellstrom.

## Error reporting

Neuron 0.6 includes resilient error handling. If there is an error in your notes, the command line tool will report them both in the console and the web interface, without breaking its workflow. This enables you to leave the daemon (`neuron rib -ws ..`) running on your server, as all errors are now reported on the generated site.

## Docker images

While Nix is still the recommended way to install, we now also have auto-created Docker images for neuron. With one `docker run ...` command, you can run the latest development version of `neuron` in a matter of seconds. The whole image is only about 100MB in size. See [Docker workflow](https://neuron.zettel.page/c6176636.html) for details.

## Automatic Publishing

You can now set up your neuron notes to publish *automatically* on the web for free. See [neuron-template](https://github.com/srid/neuron-template#readme) to get started. The gist of the idea is that we use GitHub Actions and Pages to update your published site as you change your notes in the Git repository. I publish every neuron site in this way. A [GitLab workflow](https://neuron.zettel.page/778816d3.html) also exists.

You can also of course alternatively choose to self-host your neuron site, say as a systemd service. See the [documentation on this](https://neuron.zettel.page/6479cd5e.html).

## Web & mobile app

[Cerveau](http://www.cerveau.app/) (in private beta) is the web application on top of neuron that integrates with GitHub. The idea is that you can have your cake and eat it too. A command-line based workflow to edit your notes in Git repo does not mean you can't do the same in a web application or a mobile app. Cerveau aims to address this gap, with the motto being: future-proof notes with little to no compromise on delightful user experience.

:::{.ui .message .segment}
Special thanks goes to the project sponsors, including: [Adam Bowen](https://github.com/adamnbowen), [Alex Soto](https://github.com/alex-a-soto), [Gustav](https://github.com/Whil-), [Michel Kuhlmann](https://github.com/michelk) and [Ryan](https://github.com/digilypse). 

If you enjoy using neuron, please consider [sponsoring the project](https://github.com/sponsors/srid?o=sd&sc=t) on GitHub. 💖
:::
