---
slug: haskell-foundational
---

:::{.page-note}
**Note**: This page is in its **nascent form** with much more content to be added, and then organized.
:::

Roughly there exists three autodidactic approaches to learning the individual #[[Haskell]] concepts.

1. Read tutorials & learn by doing
1. Dig into the theory behind
2. Learn GHC-level implementation details

Approach (1) is great for "getting started", but proceeding to (2) and maybe even (3) will give a more **foundational** perspective, while demystifying otherwise complex ideas. Here, I aim to collect the various resources toward that end.

## Dig into the theory behind

- https://www.haskellforall.com/2022/05/introductory-resources-to-type-theory.html
- [What I wish I knew when learning Haskell](http://dev.stephendiehl.com/hask/)
- Theory behind it all (Lambda calculus, System F, logic, etc. -- see "course" below)
	- [Programming Language Foundations in Agda](https://plfa.github.io/)
- Dependent types
	- For intuition into how type class/ type family/ data kinds/ etc fit together: https://lexi-lambda.github.io/blog/2021/03/25/an-introduction-to-typeclass-metaprogramming/
	- [[Agda]]
		- *Agda is, in some ways, the most advanced functional programming language in existence, and so if you learn how to program in Agda, you will have a very strong foundation for programming in other languages that use the idioms of functional programming.* --Verified Functional Programming in Agda, Aaron Stump
	- Idris
	
### Math

TODO

- https://www.cs.uoregon.edu/research/summerschool/summer14/lectures/zdancewic-sf-lec01.pdf
- The book 'Program = Proof' seems excellent
- https://github.com/prathyvsh/category-theory-resources


## GHC-level implementation details

[GHC User Guide](https://downloads.haskell.org/ghc/latest/docs/html/users_guide/)
: Language manual is a good starting point.
[Haskell to Core: Understanding Haskell Features Through Their Desugaring](https://serokell.io/blog/haskell-to-core)
: *"Thinking about the way Haskell language constructs are desugared into Core provides a deeper understanding of these features, rather than a superficial familiarity. For example, it provides a clear intuition for existential quantification, GADTs, and do-notation."*
: - GHC Core is “System F with Type Equality Coercions" and “System FC with Explicit Kind Equality" .... and Haskell is an abstraction over GHC Core. ([Ref](https://old.reddit.com/r/haskell/comments/qn2xwc/importance_of_lambda_calculus/hjemcat/?context=1), on relation of Haskell to typed lambda calculus)


## Todo

Where do these fit in?

- [ ] _Thinking in Types_, by isovector
- [ ] Category Theory, and other theory
- [ ] Functional Programming and Proof Checking Course Plan: https://oxij.org/activity/itmo/fp/plan/

Resources for these?

- [ ] MTL
- [ ] Lenses

Perspectives,

- [ ] Types = Values; https://vitez.me/hts-language

Create a course

- [ ] Find relevant papers, in order.
- [ ] [Write You A Haskell](https://github.com/sdiehl/write-you-a-haskell): Building a modern functional compiler from first principles.


From https://github.com/sdiehl/write-you-a-haskell/issues/93#issuecomment-962082153

> There are two good lists of foundational papers for implementing a Haskell compiler:
> 
> [https://www.stephendiehl.com/posts/essential_compilers.html](https://www.stephendiehl.com/posts/essential_compilers.html)
> 
> [https://gitlab.haskell.org/ghc/ghc/-/wikis/reading-list](https://gitlab.haskell.org/ghc/ghc/-/wikis/reading-list)
