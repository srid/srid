---
date: 2022-04-09
tags: [neovim]
slug: cli/neovim/telescope
---

# Adding a neovim plugin: telescope.nvim

![](https://user-images.githubusercontent.com/3998/162593346-e460468e-d867-46cb-8a78-2ca518629d09.png)

The [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) plugin gives us Doom Emacs-like fuzzy finder for standard editor operations, like opening files or switching buffers.

Continuing from the Nix of [[00-intro|previous post]], you only need to make two changes to the Nix to add this plugin:

1. Add the plugin to `plugins` list
   1. To find the exact Nix plugin name, look for 'telescope' in [generated.nix](https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vim/plugins/generated.nix)
   1. I found `telescope-nvim`, but I'm also going to add `telescope-zoxide` since I also use `zoxide` directory switcher.
1. Add the vim config to `extraConfig`.


```nix
{
    plugins = with pkgs.vimPlugins; [
      ...
      telescope-nvim
      telescope-zoxide
    ];
    extraConfig = ''
      ..
      nnoremap <leader>ff <cmd>Telescope find_files<cr>
      nnoremap <leader>fg <cmd>Telescope live_grep<cr>
      nnoremap <leader>fb <cmd>Telescope buffers<cr>
      nnoremap <leader>fh <cmd>Telescope help_tags<cr>
    '';
}
```

Open nvim, and hit `<leader>ff`. The leader key is by default `\`, so hit `\ ff`. This will bring up a fuzzy finder for opening files in current directory.

## Nits

I wish the plugin installation and configuration was modularized in home-manager, so that you can configure the individual plugins using Nix instead of writing vim.
