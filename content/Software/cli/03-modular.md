---
date: 2022-04-16
tags: [neovim]
slug: cli/neovim/modular
---

# Modular neovim plugin configuration

In the [[02-haskell|previous post]] I hinted about configuring neovim plugins declaratively in Nix. Today, I discovered that this is indeed possible,[^dec] in some basic form, in `home-manager`.

The feature was added in [PR \#2637](https://github.com/nix-community/home-manager/pull/2637). 

## The old way

The old way is to add your plugin in Nix,

```nix
  plugins = with pkgs.vimPlugins; [
    telescope-nvim
  ]
```

And then *separately* configure it in `init.vim` or `init.lua` --- ie., `extraConfig`, as we did in [[01-telescope]].

## The new way

However, instead, you could do both the above in the same place as:

```nix
  plugins = with pkgs.vimPlugins; [
    { 
      plugin = telescope-nvim;
      type = "lua";
      config = ''
        nmap("<leader>ff", ":Telescope find_files<cr>")
        nmap("<leader>fg", ":Telescope live_grep<cr>")
        nmap("<leader>fb", ":Telescope buffers<cr>")
        nmap("<leader>fh", ":Telescope help_tags<cr>")
        '';
    }
  }
```

https://github.com/srid/nixos-config/commit/88a202421c262ce60509feca14ce1505b726e258


[^dec]: It is not really *declarative*, though --- more like *modular*. Declarative would be how Coc is configured in home-manager; see [[02-haskell]]. Nevertheless, it is nice to be able to both configure and enable a plugin in the same place. Give the large number of neovim plugins in nixpkgs, it is not realistic to expect all of them to support declarative config anyway.
