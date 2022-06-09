---
slug: neuron-pretty-urls
date: 2021-02-23
tags: [micro/neuron]
---

Just pushed a change that enables pretty URLs in neuron generated sites. This already works in GitHub Pages (`/foo` returns `/foo.html`). [[Neuron]] had to be changed to make generated HTML link to `/foo` instead of `/foo.html`. This behaviour is controlled by:

```sh
neuron gen --pretty-urls
```

Which is also what [neuron-template](https://github.com/srid/neuron-template) does by default.

**Demo**: 
- *This* website
- https://neuron.zettel.page/
- https://alien-psychology.zettel.page/
- https://zk.zettel.page/

## Other changes

- **Default slug** is now minimally transformed: especially with `--pretty-urls`, it is useful to allow the user to reuse zettel title ID for url (except for replacing whitespace for legibility).
    - One can always explicitly specify a `slug` in the zettel YAML, as https://neuron.zettel.page/ does for virtully all of its zettels.
- Ignore zettels without date in "timeline" queries. 