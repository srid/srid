---
slug: pass
tags: [blog]
date: 2021-01-15
---

[pass](https://www.passwordstore.org/) is a simple **password manager** that stores passwords in a [gpg]-encrypted file, not some obscure database. The files can in turn be put on Dropbox, git or any other file management service.

>[!info] 1Password
>The author now uses 1Password.

## Installing

`pass` must be installed along `gpg`. On #[[NixOS]]:[^ubuntu]

[^ubuntu]: On non-NixOS Linuxes, you may want to use the native package, as home-manager's [shell completion is broken](https://github.com/nix-community/home-manager/issues/1871).

```nix
{
    # Must restart computer, otherwise you may hit this bug:
    # https://github.com/NixOS/nixpkgs/issues/35464#issuecomment-383894005
    programs.gnupg = {
      agent = {
        enable = true;
        enableExtraSocket = true;
        pinentryFlavor = "curses";
      };
    };
    environment.systemPackages = with pkgs; [
      pass
    ];
}
```

## Using

Generate a GPG key

```sh
gpg --full-gen-key
```

Initialize the password store, along with git:

```sh
pass init <email>
pass git init
```

Test:

```sh
pass insert test/example.org
pass show test/example.org
pass git push
```

## Backup GPG key in Keybase

:::{.highlight-block}
As of summer 2021, I no longer use Keybase. Re-using [[ProtonMail]] email keys is another option.
:::

Since I already use [keybase], I store my GPG key securely in [kbfs](https://book.keybase.io/docs/files), and then import it on other computers.

```sh
gpg --export-secret-keys --armor "Sridhar Ratnakumar" > ~/keybase/private/srid/gpg/me.asc
```

## Import GPG key

To import a GPG key (either from Keybase backup or from the canonical ProtonMail key):

```sh
gpg --import ~/keybase/private/srid/gpg/me.asc
gpg --edit-key <email> # and run `trust`
```

## Android support

- Setup Syncthing (use `.git` alias with `gitdir: /path/to/.git` as contents in order to exclude the git index from syncing)
- Use Android apps: Password Store & OpenKeychain 


[keybase]: https://book.keybase.io/docs/files
[gpg]: https://wiki.archlinux.org/index.php/GnuPG
