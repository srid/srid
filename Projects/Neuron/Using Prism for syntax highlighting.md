---
slug: neuron-prismjs
date: 2021-02-22
tags: [micro/neuron]
---

Up until today Neuron used Pandoc's [skylighting] to do syntax highlighting statically, however skylighting supports very limited number of languages[^lang].

[skylighting]: https://github.com/jgm/skylighting

To solve that, I decided to just switch to [Prism](https://prismjs.com/) to let the client-side do all syntax highlighting. 

Incidentally this change now allows the user to swap out their syntax hilighting library by adding it to their `head.html`.

**Documentation**: https://neuron.zettel.page/syntax-highlighting

**Breaking change?**: If you use `head.html`, yes, you must add Prism JS and CSS manually; as neuron only adds the CSS classes to the code blocks.

[^lang]: And Prism's language support is actively growing, such as getting [Idris support](https://github.com/PrismJS/prism/commit/e931441537878142adb3020cb1e38aeea9f79430) very recently.
