---
slug: x1c7-install
---

I used [these instructions](https://github.com/andywhite37/nixos/blob/master/DUAL_BOOT_WINDOWS_GUIDE.md)[^nat] to install #[[NixOS]] alongside Windows on my #[[X1C7]]

[^nat]: Note that you can use the builtin Windows disk manager to resize the partition. No need to install a third party app as this article indicates.

Note the following:

- Disable Secure Boot in BIOS. NixOS won't boot otherwise.
- Use nixos-unstable and choose the latest kernel (`linuxPackages_latest`)

As usual, refer to [the Arch wiki](https://wiki.archlinux.org/index.php/Lenovo_ThinkPad_X1_Carbon_(Gen_7)) for details.

See my [configuration.nix][x1c7.nix] for full NixOS config.

[x1c7.nix]: https://github.com/srid/nix-config/blob/master/configuration.nix/x1c7.nix

