---
slug: haskell-gotchas
---

Some of #[[Haskell]]'s gotchas:

| Gotcha                    | Recommendation                                                                                            |
| ------------------------- | --------------------------------------------------------------------------------------------------------- |
| Strings                   | [Understand](https://free.cofree.io/2020/05/06/string-types/)                                             |
| Unicode Normalization     | https://github.com/srid/neuron/issues/611                                                                 |
| Functions to avoid        | [haskell-dangerous-functions](https://github.com/NorfairKing/haskell-dangerous-functions); use [[Relude]] |
| [[ghcid]] [ghost threads] | Track all threads; or use `race_`                                                                         |
| Ratio type                | [The Hidden Dangers of Haskell's Ratio Type](https://www.fpcomplete.com/blog/hidden-dangers-of-ratio/)    |
| Laziness                  | [Comparing strict vs lazy](https://www.tweag.io/blog/2022-05-12-strict-vs-lazy/)                          |
| `TChan` and `TQueue`      | [Used bounded variants](https://www.parsonsmatt.org/2018/10/12/tchan_vs_tqueue.html) |

[ghost threads]: https://stackoverflow.com/q/24999636/55246
[relude]: https://github.com/kowainik/relude
