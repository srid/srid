---
slug: cli
---

# Make CLI Great Again 🚀

An ongoing project to get back to a CLI-centric workflow.

## Topics

* Neovim: https://github.com/srid/nixos-config/blob/master/home/neovim.nix
* Email: https://github.com/srid/nixos-config/blob/master/home/email.nix

## Motivation

- Get acquainted with CLI editing and workflows.
- Why neovim?
  - VSCode can be sluggish. 
  - Hack editor extensions in Haskell (see [nvim-hs](https://hackage.haskell.org/package/nvim-hs))
      - Maybe even write a first-class [Emanote](https://emanote.srid.ca/) extension.
- CLI email workflows: for more efficient processing (and scripting) of email

## Posts

```query {.timeline}
path:./*
```

## Todo

- terminal
  - bring up kitty on keybinding, from anywhere (for quick edits). don't rely on tmux.
- #neovim
  - [ ] Add `ee` alias to open a file with fzf directly
  - [ ] New post: adding custom Lua functions to do things (eg: zettelkasten thingy; like create new notes under dir); bind it to keybinding, appearing in which-key.
  - [[VSCode]] ➡ #neovim
    - Searching
      - [ ] Open file by searching contents
    - Saving
      - [ ] `Ctrl+S` to save
      - [ ] Autosave for Markdown notes
    - Markdown 
      - [ ] Sane indentation of lists on 'enter'
      - [ ] Disable auto-collapse.
      - [ ] Wiki-links
- #email 
  - [x] Back to ProtonMail (ProtonMail Bridge -> almost no latency from himalaya)
  - [ ] setup redirect for my Google accounts to ProtonMail.
- [ ]  #haskell
  - https://news.ycombinator.com/item?id=31152261
  - plugins from https://github.com/AstroNvim/AstroNvim
- Post ideas 
  - [ ] lazygit (basic workflows)
