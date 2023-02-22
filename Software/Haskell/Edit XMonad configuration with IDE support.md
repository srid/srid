---
slug: xmonad-conf-ide
date: 2020-11-26
tags: [blog]
---

:::{.sticky-note}
Why XMonad? Because this opens me up to write complex workflows in Haskell with its type-safety benefits.
:::

[Over at FP Zulip](https://funprog.srid.ca/haskell/i3-configuration-in-haskell.html#217619324), when I floated the idea of writing Haskell DSL for i3 configuration, someone suggested to just use #[[XMonad]] instead. XMonad is a window manager where your configuration file is just Haskell code. 

Because it is all Haskell, we can use [`haskell-language-server`](https://github.com/haskell/haskell-language-server) to provide full IDE support -- autocomplete, hover popups, documentation links, etc. -- for editing window manager configuration.

![[static/xmonad-vscode.jpeg]]

Here's how you do it:

1. Create a cabal project (see [[Creating a new Haskell project with IDE support using Nix]])
2. Add your XMonad configuration to the `Main.hs`
3. Add `xmonad`, `xmonad-contrib` and other dependencies to the cabal file
4. Adjust your #[[NixOS]] XMonad configuration to use this project

Step 4 basically involves using the `Main.hs` as the config file, as well as copying over the Cabal dependencies. So, in your `configuration.nix` you would do something like:

```nix
services.xserver.windowManager.xmonad = {
  enable = true;
  extraPackages = haskellPackages: [
    haskellPackages.xmonad-contrib
    haskellPackages.containers
  ];
  enableContribAndExtras = true;
  config = pkgs.lib.readFile ./xmonad-config/Main.hs;
};
```

Your Cabal project lives at `./xmonad-config` ... and, if you followed the instructions in [[Creating a new Haskell project with IDE support using Nix]] to setup IDE configuration, you can simply launch [[VSCode]] using `code ./xmonad-config` to start editing your configuration.

## Example

- [My config: nixos/xmonad-srid](https://github.com/srid/nixos-config/tree/master/nixos/desktopish/xmonad/xmonad-srid)
- [Taffybar, done similarly](https://github.com/srid/nixos-config/tree/master/nixos/desktopish/taffybar/taffybar-srid)

## Discussion

- [r/haskell](https://old.reddit.com/r/haskell/comments/k1kcif/edit_xmonad_configuration_with_ide_support/)
