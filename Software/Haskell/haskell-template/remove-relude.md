---
slug: haskell-template/relude
---

# Removing `relude`

[[haskell-template]] uses [[Relude]] as the alternative "prelude" due to convenience and safety. I recommend that you use relude. However, if you want to remove it, you can do so as follows:

- In the `.cabal` file:
  - Remove `relude` from the `build-depends` section.
  - Remove the `mixins` section entirely.
- In the `.hlint.yaml` file, delete all lines from the line that reads "Relude's .hlint.yaml goes here".
- Open `src/Main.hs` and replace any relude functions with their `base` equivalents. 
  - For example, `putTextLn` becomes `putStrLn`.