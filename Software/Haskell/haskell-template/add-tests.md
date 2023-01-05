---
slug: haskell-template/tests
---

# Adding tests

[[haskell-template]] does not include tests by default (see [[philosophy]]), but you may add them as follows:

1. Split any logic code out of `Main.hs` into, say, a `Lib.hs`.
1. Correspondingly, add `other-modules: Lib` to the "shared" section of your cabal file.
1. Add `tests/Spec.hs` (example below):
    ```haskell
    module Main where

    import Lib qualified
    import Test.Hspec (describe, hspec, it, shouldContain)

    main :: IO ()
    main = hspec $ do
      describe "Lib.hello" $ do
        it "contains the world emoji" $ do
          toString Lib.hello `shouldContain` "🌎"
    ```
1. Add the tests stanza to the cabal file:
    ```yaml
    test-suite tests
        import:         shared
        main-is:        Spec.hs
        type:           exitcode-stdio-1.0
        hs-source-dirs: tests
        build-depends:  hspec
    ```
1. Update `hie.yaml` accordingly; for example, by adding,
    ```yaml
      - path: "tests"
        component: "test:tests"
    ```
1. Add the test command to the mission-control scripts section of the flake file
    ```nix
      mission-control.scripts = {
        test = {
          description = "Run all tests";
          exec = ''
             ghcid -c "cabal repl test:tests" -T :main
          '';
          };
      };
    ```
1. Commit your changes to Git, and test it out by running `, test` from the dev shell.
