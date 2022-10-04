---
slug: nojs
---

[[Haskell]] programmers like me who have gotten used to functional programming and static typing find JavaScript to be painful to use. We can't avoid JavaScript entirely -- there are some useful JS libraries out there in the world -- however for actual app development we can continue using *safer* programming languages (see below) via either a JS-transpiler or a [Wasm](https://webassembly.org/)-compiler. 


| Language        | Toolkits                                                | Notes                                                                                                                                     |
| --------------- | ------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| [[Haskell]]     | GHCJS; [[Reflex-FRP]]#; [[Obelisk]]                     | Developed by a small consultancy (Obsidian Systems) with uncertain future; also see Tweag's [Asterius](https://github.com/tweag/asterius) |
| F# / .NET       | [Blazor](https://srid.github.io/learning-fsharp/Blazor) | Can expect Microsoft's investment to provide it a solid future.                                                                           |
| [[Rust]][^nofp] | [Yew](https://yew.rs/)[^trunk]                          | Has an [actively evolving](https://www.arewewebyet.org/topics/frameworks/#frontend) wasm story; needs further exploration                 |

[^trunk]: via https://github.com/yewstack/yew-trunk-minimal-template for JS-less dev tools.

[^nofp]: Quoting Michael Snoyman, however, "*Rust is not a functional programming language, it’s imperative; [...] Rust does adhere to many of the tenets of functional programming; [...] In many cases, you can easily, naturally, and idiomatically write Rust in a functional style*" https://www.fpcomplete.com/blog/2018/10/is-rust-functional/

## Blog posts on #nojs/main

```query {.timeline}
tag:#nojs
```

## Related

- [[PureScript]] generally relies on NodeJS toolchain being peppered in the project repo, but [purs-nix](https://github.com/ursi/purs-nix) aims to provide a "No JavaScript" development environment using [[Nix]].