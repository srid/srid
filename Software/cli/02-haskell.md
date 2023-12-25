---
date: 2022-04-15
tags: [neovim, haskell]
slug: cli/neovim/haskell
---

# Haskell Language Server and Coc

[[Haskell]] has great IDE support via #[[haskell-language-server]] (HLS).

[Coc.nvim](https://github.com/neoclide/coc.nvim) is the recommended extension to get Language Server Protocol (LSP) support for editing Haskell in neovim.

It turns out that [`home-manager`](https://github.com/nix-community/home-manager/blob/master/modules/programs/neovim.nix) has a module that, unlike the [[NixOS]] version, provides a declarative way to install and configure coc.nvim with Haskell support (EDIT: this is [language-independent](https://github.com/srid/nixos-config/commit/32c3a733e0768d75d6c7c294a9473305a5c5a928)):

```nix
{
  programs.neovim = {
    coc = {
      enable = true;
      settings = {
        languageserver = {
          haskell = {
            command = "haskell-language-server-wrapper";
            args = [ "--lsp" ];
            rootPatterns = [
              "*.cabal"
              "cabal.project"
              "hie.yaml"
            ];
            filetypes = [ "haskell" "lhaskell" ];
          };
        };
      };
    };
  };
}
```

https://github.com/srid/nixos-config/commit/9a6410331063ae97ae405837559cf4c5b3990ada

It does work when trying out in the nix-shell of [[haskell-template]].

## Declarative plugin config in Nix

The above is neat---no need to hand-write VimScript or Lua just to configure the extension. Can we do the same for *other* neovim extensions in Nix? A couple of attempts exist: [nix-neovim](https://github.com/syberant/nix-neovim) and [NixVim](https://github.com/pta2002/nixvim).
