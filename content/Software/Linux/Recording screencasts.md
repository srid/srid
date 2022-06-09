---
slug: screencast
tags: [micro]
date: 2021-04-27
---

GNOME runs on  #[[NixOS]] by default using Wayland, however [Peek] works only in X. For the [[Ema]] demo, I recorded a short screencast spawning two windows, [[VSCode]] and web browser, as follows:

- Disconnect from external monitor
- Logout and login choosing X over Wayland in the login screen
- Go to display settings: reduce resolution and increase scalling 
- Arrange two windows side by side
- Open [Peek] and record

Some tips before recording:

- Practice a few attempts before; it is good to avoid unnecessary delays, and unnecessary UI interactions and dialogs

The screencast I produced is [available here](https://ema.srid.ca/static/ema-demo.mp4) (and is used in [[Announcing Ema - Static Sites in Haskell|this blog post]]). It weighs almost 700KB, though perhaps it could be compressed (`ffmpeg`?) without much loss in quality.

[Peek]: https://github.com/phw/peek
