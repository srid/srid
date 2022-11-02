---
slug: haskell
---

[Haskell](https://www.haskell.org/) is an advanced, purely functional programming language. I use Haskell because of its correctness guarantees that are difficult or impossible to achieve with mainstream programming languages[^gotcha].

[^gotcha]: Do be wary of [[Haskell Gotchas]].

My first foray into Haskell was to write fullstack web applications using [[Reflex-FRP]], after having used [[Elm]] prior to that. Nowadays I consider it my go-to language for general application development.

[On GitHub](https://github.com/srid) you can find a list of Haskell projects I work on, the notable of which are [[Neuron]], [[Ema]] and [[Emanote]].

## Learning Haskell

If you wish to learn Haskell yourself, these pointers may be of help:

Get Inspired
: [10 Reasons to Use Haskell](https://serokell.io/blog/10-reasons-to-use-haskell)
: [Why Haskell is Important](https://www.tweag.io/blog/2019-09-06-why-haskell-is-important/)
: [Why Haskell matters](https://wiki.haskell.org/Why_Haskell_matters).

Attitude
: Lose the limiting beliefs, if any.[^lb] Approach Haskell, with maximum [locus of control], as if it is a new programming language that had been created this year (ie. sans any vague preconceptions [introjected] from [[Cynical non-pioneers|naysayers]]).

Books
: Some prefer *concise* learning materials; if this is you, check out the two books by Graham Hutton and Richard Bird. For a thorough and practical book, Vitaly Bragilevsky's Haskell in Depth or Will Kurt's Get Programming with Haskell might be of interest. Books are only a starting point (see the next two sections).

Self-learning courses
: [fp-course](https://github.com/system-f/fp-course) and [applied-fp-course](https://github.com/qfpl/applied-fp-course)

Practice
: Learning anything takes practice, and this is particularly a key for a purely functional language like Haskell. See [Haskell Mentors List](https://willbasky.github.io/Awesome-list-of-Haskell-mentors/) for progressing in learning Haskell by way of contributing to open source projects that you already enjoy using.

Talk / Share
: Join [FP Slack] to chat with other Haskellers (the Slack also has rooms for other FP languages). If you prefer a forum-like format, post to [StackOverflow \#haskell](https://stackoverflow.com/questions/tagged/haskell), which has been quite helpful in my experience. Read [r/haskell](https://old.reddit.com/r/haskell/) for news. Be wary of other communities.[^wk] If you are interested in hacking on my open source projects, join [this room on Matrix](https://matrix.to/#/#srid-haskell:matrix.org) (it is a part of [Awesome-list-of-Haskell-mentors](https://github.com/willbasky/Awesome-list-of-Haskell-mentors)). See [Haskell Planetarium](https://haskell.pl-a.net/) for recent Haskell news & discussions.

Deepen your Haskell knowledge
: [[Haskell from the ground up]] (Work in progress)

[locus of control]: https://www.wikiwand.com/en/Locus_of_control

[^wk]: In particular, you want to avoid the non-[[Stay niche|niche]] ones [[woke-invasion|invaded]] by [[woke|woke]] activist moderators.

## Take the red pill with Nix

If you are feeling adventurous consider getting acquainted with [[Nix]], which in turns allows you to leverage [[haskell-template]] for bootstraping Haskell projects with full IDE support in [[VSCode]]. This works on [[Linux]], [[macOS]] and [[Windows]] (via WSL) without having to install dependencies other than Nix itself. In my opinion, this is the best way to set up a Haskell development environment.

[FP Slack]: https://fpslack.com
[introjected]: https://archive.is/rUiwZ#selection-187.47-205.10


[^lb]: 
      Graham Hutton: "[*My experience is that people need to be 'ready' to learn what a monad is.  If they are ready, it's not too difficult, but still requires quite a bit of effort - as with anything worthwhile.*](https://archive.is/Teseb)"

      Travis Whitaker: [*How do you know the difference between "novelty budget" and "inertia" and "sunk cost fallacy?"*](https://archive.is/qqEt7)
