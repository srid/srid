---
slug: haskell-template/start
---

# Getting started

## First-time setup

### Nix

Before you can use [[haskell-template]], we will need to setup a few things on your system.

- [Install Nix](https://nixos.org/download.html) (version must be 2.8 or greater) 
    - If you are using Windows, you may install Nix [under WSL2](https://nixos.wiki/wiki/Nix_Installation_Guide#Windows_Subsystem_for_Linux_.28WSL.29) 
- [Enable Flakes](https://nixos.wiki/wiki/Flakes)
- `git clone` haskell-template and run `nix develop -i -c haskell-language-server` in it to sanity check your environment 

### VSCode

While you may use any text editor with language-server support, we will use [[VSCode]] because it is the easiest way to get started.

- Launch [[VSCode]], and open the `git clone`'ed haskell-template directory [as single-folder workspace](https://code.visualstudio.com/docs/editor/workspaces#_singlefolder-workspaces)
- When prompted by VSCode, install the [workspace recommended](https://code.visualstudio.com/docs/editor/extension-marketplace#_workspace-recommended-extensions) extensions.
    - If it doesn't prompt, press <kbd>Ctrl+Shift+x</kbd> and search for `@recommended` to install them all manually.
- Press <kbd>Ctrl+Shift+P</kbd> to run the command "Nix-Env: Select Environment" and then select `shell.nix`. 
     - The extension will ask you to reload VSCode at the end. Do it.

## Running in VSCode

### Test that [[haskell-language-server]] works

- Open `src/Main.hs`, and notice [[haskell-language-server]] launching in the footer.
- Hover your mouse over something, say `putTextLn`, and see the hover tooltip giving you the type signature.
    - This means the IDE support works!

### Test that [[ghcid]] works

- Launch the terminal inside VSCode
- Run `bin/run`.

This will launch [[ghcid]] to run the `main` entrypoint in `src/Main.hs`. 

- Modify `src/Main.hs` and save it.

This should have `bin/run` instantly re-compile and re-run the program.

Note: you can also press `<kbd>Ctrl+Shift+B</kbd>` to run `bin/run`.