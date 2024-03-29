---
slug: haskell-template/start
---

# Getting started

## First-time setup

If this is your first time using [[Nix]] or [[haskell-template]] (or a project based on it) you will initially need to setup a few things on your system.

### Nix

- [Install Nix](https://nixos.asia/en/install) (version must be 2.8 or greater) 
    - If you are using Windows, you may install Nix [under WSL2](https://nixos.wiki/wiki/Nix_Installation_Guide#Windows_Subsystem_for_Linux_.28WSL.29) 
- In the project directory, run `nix develop -i -c haskell-language-server` to sanity check your environment.
  - This will download the required dependencies and cache them to the local Nix store. If it succeeds, it means everything's good.
- [Install direnv](https://nixos.asia/en/direnv)
  - **NOTE**: If you choose not to use direnv, you must launch VSCode from _inside_ of `nix develop` shell.

### VSCode

While you may use any text editor with language-server support, we will use [[VSCode]] because it is generally the easiest way to get started.

- Launch [[VSCode]], and open the `git clone`'ed project directory [as single-folder workspace](https://code.visualstudio.com/docs/editor/workspaces#_singlefolder-workspaces)
  - NOTE: If you are on Windows, you must use the [Remote - WSL extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl) to open the folder in WSL.
- When prompted by VSCode, install the [workspace recommended](https://code.visualstudio.com/docs/editor/extension-marketplace#_workspace-recommended-extensions) extensions.
    - The direnv extension will load the nix shell.
     - The extension will ask you to restart VSCode at the end. Do it.

## Running in VSCode

Once the project has been reloaded in VSCode, you are ready to start developing it. But first, it is useful to sanity check a few things:

### Test that [[haskell-language-server]] works

- Open `src/Main.hs`. 
  - Notice [[haskell-language-server]] launching in the footer (you should see "*Processing (1/2)*"), and wait for it finish.
- Hover your mouse over something, say `putTextLn`, and see the hover tooltip giving you the type signature.
    - This means the IDE support works!

### Test that [[ghcid]] works

- Launch the terminal inside VSCode
- Run `nix develop` shell and run `just run`.
    - This will launch [[ghcid]] to run the `main` entrypoint in `src/Main.hs`. 
- Modify `src/Main.hs` and save it.

This should have `just run` instantly re-compile and re-run the program.

Note: you can also press <kbd>Ctrl+Shift+B</kbd> to run `just run`.

## Rename the project

Finally, if you are going to be using this template for a real project, you should rename it.

```sh
NAME=myproject
# First, click the green "Use this template" button on GitHub to create your copy
# You may name the new repository to be the same as $NAME
git clone <your-clone-url> $NAME
cd $NAME


# Copy-paste these 4 lines at the same time
git mv haskell-template.cabal ${NAME}.cabal
nix run nixpkgs\#sd -- haskell-template ${NAME} * */*
echo "# ${NAME}\n\n" > README.md
git add . && git commit -m rename
```

## Next steps

See [[haskell-template]] for further documentation.
