---
slug: clear-linux
---

[Clear Linux](https://clearlinux.org/) is an optimized Linux distribution by Intel.

It performs better than [[NixOS]] as desktop experience on [[X1C7]], thus improving on [[X1C7 - Moderate Performance]]. In addition, the system is much more reliable, such as there not being any [[X1C7 WiFi issue]] (or Thunderbolt issues) so far.

## App notes

- If using NVIDIA, its proprietary drivers must be [manually installed](https://docs.01.org/clearlinux/latest/zh_CN/tutorials/nvidia.html) (be sure to copy the long CLI commands in a text file before rebooting the computer post-nouveau-deactivation to avoid having to type them all)
- **Brave** browser: needs to be [manually updated](https://community.clearlinux.org/t/installing-brave-browser-on-clear-linux/1131)
- [[VSCode]] 
  - Flatpak install has broken terminal shell (uses some sandboxed shell); install vscode [using .rpm](https://community.clearlinux.org/t/best-way-to-install-rpms/5036) instead.
  - settings sync: GitHub opens a new VSCode instance, and thus breaks. Manually copy-pasting the auth token in the original window works.
    - Sometimes also [Error code 801](https://github.com/microsoft/vscode-pull-request-github/issues/1221)

## External links

- [NixOS tracker discussion](https://github.com/NixOS/nixpkgs/issues/63708) on adopting Clear Linux patches