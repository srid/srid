---
date: 2022-04-22
tags: [neovim, email]
slug: cli/email
---

# Command-line email

Can we use Neovim as an email client? Yes, this is actually possible [using Himalaya](https://github.com/soywod/himalaya/tree/master/vim)!

As a first step, though, we should enable Himalaya itself using [[Nix]]. `home-manager` provides a module for that. Without much ado:

```nix
{
  programs.himalaya = {
    enable = true;
  };
  accounts.email.accounts = {
    icloud = {
      primary = true;
      himalaya.enable = true;
      address = "srid@srid.ca";
      realName = "Sridhar Ratnakumar";
      userName = "happyandharmless";
      passwordCommand = "op item get iCloud --fields label=himalaya";
      imap = {
        host = "imap.mail.me.com";
        port = 993;
        tls.enable = true;
      };
      smtp = {
        host = "smtp.mail.me.com";
        port = 587;
        tls.enable = true;
      };
    };
  };
}
```

I added my iCloud account details. Note that `passwordCommand` uses 1Password's CLI tool, which uses Mac's Touch ID authentication. I generated an App-specific password and put it under the "himalaya" label of the iCloud entry in 1Password. As a result, we get a no-fuss way to read email!

![[himalaya.png]]

https://github.com/srid/nixos-config/commit/1c188414286f5e81f0ea4a0e3ccd4ed555241f69

## Vim extension

Installing the Vim extension is fairly simple:

```nix
      (pkgs.vimUtils.buildVimPlugin {
        name = "himalaya";
        src = inputs.himalaya + /vim;
      })
```

https://github.com/srid/nixos-config/commit/9bb76425b78906830a72846e005eb551b7a9eef4

The Vim extension is not bad. But it does bring up the Mac Touch ID prompt upon *every* email operation, which needs to be fixed.

