---
date: 2022-04-08
tags: [neovim]
slug: cli/neovim/install
---

# Install Neovim on Linux/macOS using Nix

Regardless of the platform, you can use the exact [[Nix]] specification to install and configure Neovim.

https://github.com/srid/nixos-config/blob/04a3ddeb3ee8ef1ba793a876fac10f759cda500b/home/neovim.nix

The home-manager module:

```nix
{ pkgs, inputs, system, ... }:
let
  neovim-nightly = inputs.neovim-nightly-overlay.packages.${system}.neovim;
in
{
  programs.neovim = {
    enable = true;
    package = neovim-nightly;

    extraPackages = [
    ];

    plugins = with pkgs.vimPlugins; [
      vim-airline
      papercolor-theme
    ];

    extraConfig = ''
      set background=light
      colorscheme PaperColor
    '';
  };
}
```

Then, in your `home.nix` (or `flake.nix` if using the homeManager module):

```nix
imports = [ ./neovim.nix ]
```

- NixOS: https://github.com/srid/nixos-config/blob/04a3ddeb3ee8ef1ba793a876fac10f759cda500b/flake.nix#L53
- macOS: https://github.com/srid/nixos-config/blob/04a3ddeb3ee8ef1ba793a876fac10f759cda500b/flake.nix#L133

