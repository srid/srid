---
slug: omarchy
---
Omarchy is a much hyped [[Linux]] distro by DHH who has a distaste for [[macOS]]. It is based on Arch Linux and uses [[Hyprland]].


## On [[P14s]] {#p14s}

The author tried setting up Omarchy on his [[P14s]] and observed it to be somewhat lackluster compared to just using [[M1 Macbook Pro 16]].

### Problems, with workaround

WiFi adapter stops being recognized after first update and reboot
: `sudo pacman -S linux-firmware && sudo pacman -S linux`; then reboot

### Known Hardware issues {#hw}

[[Apple Studio Display]]
: - Sound does not work
  - Webcam does not work

Webcam
: - Built-in webcam is not even recognized

### Known Software issus {#soft}

Chromium
: Some tabs won't close/refresh/navigate; just grays out until you press ESC. ([Bug](https://support.google.com/chrome/thread/122093768/can-not-close-tabs-greyed-out-only-can-use-keyboard-shortcuts?hl=en))

## Getting [[Nix]] dev env working {#nix}

- [x] [Install Nix](https://nixos.asia/en/install)
- [ ] Setup direnv through home-manager
	- [ ] Integrate with existing Omarchy bash dotfiles

## External Links

- https://omarchy.org/