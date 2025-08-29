---
slug: lxc-nixos
tags: [blog]
date: 2020-03-25
---

>[!warning]
>I now use `incus` over `lxc`. Accordingly, this page needs an update; but for now, see [srid/nixos-config](https://github.com/srid/nixos-config/tree/master/modules/flake-parts/incus-image).


>[!note]
> If you wish to run #[[NixOS]] container on a NixOS host, checkout NixOS's [declarative container management](https://nixos.org/manual/nixos/stable/#ch-containers) which may be a more appealing option than LXD. For VMs, see [microvm.nix](https://github.com/astro/microvm.nix).


Often I find myself needing a *pristine* Linux system for testing some program that is expected to work on a user's machine with an environment that is possibly quite different to mine. I could spin up a virtual machine, but that is too heavyweight. Alternatively, I could use Docker, but a Docker container is conceptually more of a process and less of a system. 

Enter [LXD](https://linuxcontainers.org/lxd/introduction/), which advertises itself as offering a *"user experience similar to virtual machines but using Linux containers instead."* Or, as [u/Floppie7th](https://old.reddit.com/r/selfhosted/comments/b50h9t/docker_vs_lxd/) puts it, *"LXD makes 'pet' containers. Basically, VMs without the virtual hardware and extra kernel."* In other words, LXD allows us to spin up lightweight (Linux) VMs on a Linux machine, where one cares more about the separation of userland than hardware or kernel.

## Installing lxd 

On NixOS, you can install LXD by adding `virtualisation.lxd.enable = true;` to your configuration.nix. You might also want to add yourself to the `lxd` user group so as to not have to use `sudo` when running the `lxc` command. Add these to your `configuration.nix`:

```nix
  virtualisation.lxd.enable = true;

  users.users.srid = {
    extraGroups = [ "lxd" ];
  };
```

## Initial setup

Run `sudo lxd init` to initialize LXD.

## Running a Ubuntu container

Let us run a bare Ubuntu container to get started:

```bash
# You might first have to run `lxd init` to initialize LXD
#
# You can run `lxc image list images: | grep ubuntu` to see availablke images
#
lxc launch ubuntu:noble pristine -c security.nesting=true
```

(Note that `security.nesting` flag is being enabled so that we may be able to install Nix later; you may leave it disabled if you would not be using Nix).

We named the container "pristine", and you can check its status in `lxc list`---it should be in the RUNNING state.

### Entering the container 

This will drop us in the root shell:

```bash
lxc exec pristine -- /bin/bash
```

However, usually, it is better to create a user account (with sudo access) first, and then use it:

```bash
lxc exec pristine -- adduser --shell /bin/bash --ingroup sudo srid
```

Then you may directly log in as that user as follows:

```bash
lxc exec pristine -- su - srid -c 'tmux new-session -A -s main'
```

Note that we use `tmux` so that programs requiring tty will work correctly.


### Installing Nix 

Assuming you have enabled the `security.nesting` flag on the container, you should now be able to [install Nix](https://github.com/DeterminateSystems/nix-installer).

I use Nix to develop and install my programs, so the above is all I need to do in order to begin testing them on a pristine Linux machine without much fanfare.

## Running a NixOS container

The official image server for LXD does not support NixOS. However, we can build our own using [nixos-generators](https://github.com/nix-community/nixos-generators). Let's wrap the commands in a script (call it [`buildLxcImage.sh`](https://github.com/srid/nix-config/blob/adce2673d6f2fdf6dfd9466612a71fda6da72961/device/lxc/buildLxcImage.sh)):

```bash
#! /usr/bin/env nix-shell
#! nix-shell -p nixos-generators
#! nix-shell -i bash
set -xe

CONFIGURATIONNIX=$1
METAIMG=`nixos-generate -f lxc-metadata`
IMG=`nixos-generate -c ${CONFIGURATIONNIX} -f lxc`

lxc image delete nixos || echo true
lxc image import --alias nixos ${METAIMG} ${IMG}
```

You will need a `configuration.nix` (see [mine][lxc.nix]) to build a NixOS image, using this script:

[lxc.nix]: https://github.com/srid/nix-config/blob/adce2673d6f2fdf6dfd9466612a71fda6da72961/device/lxc.nix

```bash
# Builds the "nixos" lxc image
./buildLxcImage.sh configuration.nix
```

Then launch a container:

```bash
lxc launch nixos childnixos -c security.nesting=true
```

Access its root shell:

```bash
lxc exec childnixos -- /run/current-system/sw/bin/bash
```

If the configuration.nix also declares a user account, you can instead directly log in as that user:

```bash
lxc exec childnixos -- /run/current-system/sw/bin/su - srid  \
  -c 'tmux new-session -A -s main'
```

