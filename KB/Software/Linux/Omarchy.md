---
slug: omarchy
---
Omarchy is a much hyped [[Linux]] distro by DHH who has a distaste for [[macOS]]. It is based on Arch Linux and uses [[Hyprland]].

## On [[ThinkPad P14s]] {#p14s}

The author tried setting up Omarchy on his [[ThinkPad P14s]] and observed it to be somewhat lackluster compared to just using [[M1 Macbook Pro 16]].  On the positive side, the [[Hyprland]] experience is great ... and [[Linux]] does engage a delightful keyboard-centric workflow (see [[cli]]).

### Problems, with workaround

WiFi adapter stops being recognized after first update and reboot
: `sudo pacman -S linux-firmware && sudo pacman -S linux`; then reboot

### Known Hardware issues {#hw}

[[Apple Studio Display]]
: - Sound does not work
  - Webcam does not work
  - USB ports don't work
  
### Known Software issues {#soft}

Chromium
: Some tabs won't close/refresh/navigate; just grays out until you press ESC. ([Bug](https://support.google.com/chrome/thread/122093768/can-not-close-tabs-greyed-out-only-can-use-keyboard-shortcuts?hl=en))

## Additional setup
### Getting [[Nix]] dev env working {#nix}

This is fairly simple using home-manager. First, [install Nix](https://nixos.asia/en/install) and then setup home-manager based on [my configuration](https://github.com/srid/nixos-config/blob/e2b7f3fbc931b9cbc440f9a3139be2cdf2808dfd/configurations/home/srid%40vixen.nix). Notice I discard Omarchy's `.bashrc` in favour of the direnv-friendly starship setup.

### Others

- [ ] Ad blocking (I use Adguard on macOS)

## In lieu of Macbook Trackpad {#cli}

Contrary to popular belief, my fingers tend to stay close to the 'home row' on macbook more than on any other system, due to the fact the trackpad enables excellent maneuver of the mouse cursor. While Thinkpad has the iconic trackpoint, it is still not as usable as the Mac trackpad. So to counteract this, we need to ==setup keyboard-centric workflow== wherever possible reaching out to mouse only where necessary.

Chromium
: Use the *Vimium* extension

Obsidian:
: Settings -> Editor -> Enable Vim mode

## Focus

Finally, one advantage of using a tiling window manager is the **calm focus** it enables on whatever you are working on. In contrast, when windows are *spread across* - it can facilitate a chaotic vibe of distraction as an undercurrent. I can't help but appreciate this calm focus despite all the problems above.  After all, [[This Moment|this is the only moment]] there is.

## External Links

- https://omarchy.org/