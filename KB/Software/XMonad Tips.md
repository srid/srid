---
slug: xmonad-tips
---

Note that the `<super>` key is usually `Win` or `Alt`, to the left of the space bar.

---

1. Press `<Super>-Shift-Enter` to open the **terminal**
1. Press `<Super>-p` to launch dmenu (**application launcher**)
1. **Layouts**
	1. `ThreeCol` (useful for wider screens)
	```haskell
	myThreeCol =
      ThreeColMid
        1 -- Master window count
        (3 / 100) -- Resize delta
        (1 / 2) -- Initial column size
	```
	1. [Tabbed](https://hackage.haskell.org/package/xmonad-contrib-0.17.0/docs/XMonad-Layout-Tabbed.html) (useful when managing related windows *one at a time*)
1. `<Super>-h/l` - resize active window
1. `<Super>-j/k` - switch focus to left/right window
1. `<Super>-w/e` - switch focus to other monitor
1. More keybindings [here](https://wiki.haskell.org/wikiupload/d/d6/Xmbindings.svg) (poster-friendly)
1. Ideas for **keybindings**
	1. Screenshot mouse-selected region to clipboard
	```nix
	# In NixOS, add this to your packages list:
	pkgs.writeScriptBin "screenshot"
	  '' 
	  #!${pkgs.runtimeShell}
	  ${pkgs.maim}/bin/maim -s | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png
	  '';
	```
1. Integrations
	1. If you are using [[Pass with GPG]], `passmenu` can be invoked from dmenu (see above) to get autocompletion in passwords.