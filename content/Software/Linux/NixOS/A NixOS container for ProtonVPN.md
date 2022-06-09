---
slug: protonvpn-nixos-container
tags: [micro]
date: 2021-03-03
---

:::{.page-note}
**NOTE**: This article is incorrect, but you should use `nixos-shell`; see [instructions here](https://github.com/srid/nixos-config/pull/14).
:::

#[[NixOS]]'s [declarative container management](https://nixos.org/manual/nixos/stable/#ch-containers) provides a way to *declaratively* configure an *entire* (NixOS) Linux system to be run inside the host. Below you will find the Nix config that configures a new container named "vpn" in the following way:

- Add the specified system packages
- Add the specified user

Of course, you can do more - such as adding systemd services, configuring firewall, etc. But for this post, we are interested only in creating an **isolated system** that will connect to a VPN network whilst leaving the rest of your computer remain connected without VPN[^dis]. 

```nix
  containers.vpn = { 
    config =  { config, pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        protonvpn-cli  # Our VPN client
        tmux
        youtube-dl
        aria
      ];
      users.extraUsers.user = {
        isNormalUser = true;
        uid = 1000;
      };
    };
  };
```

Add the above to your host's `configuration.nix`, and then `nixos-rebuild switch`. Now you can start the container as:

```sh
sudo nixos-container start vpn
```

And access its root shell as:

```sh
sudo nixos-container root-login vpn
```

From within the root shell, you will want to login to your [ProtonVPN](https://protonvpn.com/) account:

```sh
protonvpn init
```

Connect to VPN,

```sh
protonvpn c --fastest
```

And then login as a non-root user (important!) with tmux:

```sh
su - user -c "tmux new -A"
```

From here, you can use your favourite network clients to access the outside world through VPN.

[^dis]: In particular, the `protonvpn` Linux client is not always reliable over long-time; it is not uncommon to find my home-server host unreachable from the outside due to a frozen VPN connection. 