---
slug: nix-haskell-static-binaries
tags: [blog]
date: 2020-09-29
---

Static binaries are useful to distribute #[[Haskell]] applications without requiring the user to build it themselves. Fully static Haskell executables are *mostly* supported by #[[Nix]]; see [this issue][issue] for details on what's left.

To get started quickly with building static binaries for your Haskell project,

1. Nixify your project: write a `default.nix` (See [[Nix recipes for Haskellers]])
1. Switch to a fork of [nixpkgs] reverting `3c7ef6b`.[^revert]
   1. You can try [mine][nixpkgs-fork].
1. Write a `static.nix` (see below), that invokes this `default.nix`, using [musl] to build your app with static linking
1. Run `nix-build static.nix` to produce a static binary under `./result/bin`
   1. Expect it to take a long time as it builds everything from source.

```nix
let 
  # Assuming we pin nixpkgs using https://github.com/nmattia/niv
  sources = import ./nix/sources.nix;
  # Your nixpkgs fork (see step 2 above)
  nixpkgs = import sources.nixpkgs-fork { };
  # Use `pkgsMusl` for static libraries to link against
  pkgs = nixpkgs.pkgsMusl;
  # This is your Haskell app compiled normally.
  # It's default.nix takes a `pkgs` argument which we override with `pkgsMusl`
  myapp = import ./default.nix { inherit pkgs; };
  inherit (pkgs.haskell.lib) appendConfigureFlags justStaticExecutables;
in 
  # All that's left to do is call `justStaticExecutables` to configure Cabal to
  # produce a static executable, as well as add the necessary GHC configure
  # flags to link against static libraries.
  appendConfigureFlags (justStaticExecutables ka)
    [
      "--ghc-option=-optl=-static"
      "--extra-lib-dirs=${pkgs.gmp6.override { withStatic = true; }}/lib"
      "--extra-lib-dirs=${pkgs.zlib.static}/lib"
      "--extra-lib-dirs=${pkgs.libffi.overrideAttrs (old: { dontDisableStatic = true; })}/lib"
      "--extra-lib-dirs=${pkgs.ncurses.override { enableStatic = true; }}/lib"
    ]
```

## Other changes you might need to make

More complex projects may require additional fixes and workarounds.

* If you see the error `crtbeginT.o: relocation R_X86_64_32 against hidden symbol '__TMC_END__'`, you might want to add `"--disable-shared"` to the configure flags (see above).[^tmc]
* Some tests may fail on musl (eg: [hslua]); disable them using `dontCheck`

For [[Neuron]] in particular, see [this PR][neuron-pr] for the actual changes to support building static binaries on Linux.

## macOS

macOS does not support fully static binaries. And there is nothing in nixpkgs to build partially static binaries either.

[issue]: https://github.com/NixOS/nixpkgs/issues/43795
[musl]: https://musl.libc.org/
[nixpkgs]: https://github.com/NixOS/nixpkgs
[nixpkgs-fork]: https://github.com/srid/nixpkgs/commits/static
[hslua]: https://github.com/hslua/hslua/issues/67
[neuron-pr]: https://github.com/srid/neuron/pull/417/files

[^revert]: See <https://github.com/NixOS/nixpkgs/issues/85924#issuecomment-619199832>
[^tmc]: See [this recommendation](https://logs.nix.samueldr.com/nixos/2019-05-11#2210564;) by nh2 on IRC. Though, a better solution seems to be to make the GHC bootstrap binary use ncurses6. See [issue \#99](https://github.com/nh2/static-haskell-nix/issues/99#issuecomment-665400600).
