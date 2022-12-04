---
slug: block-social-media
tags: [micro]
date: 2021-04-16
---

Add this to your #[[NixOS]] Linux `configuration.nix`:

```nix
{
  networking.extraHosts =
    ''
      127.0.0.1 reddit.com
      127.0.0.1 www.reddit.com
      127.0.0.1 np.reddit.com
      127.0.0.1 old.reddit.com
      127.0.0.1 www.old.reddit.com

      127.0.0.1 news.ycombinator.com
      127.0.0.1 hckrnews.com

      127.0.0.1 twitter.com
      127.0.0.1 www.twitter.com
      127.0.0.1 mobile.twitter.com
    '';
}
```

- On [[Windows]], the file to modify is `c:\windows\system32\drivers\etc\hosts`.
- On [[macOS]], the file to modify is `/private/etc/hosts`