set -xe

nix shell nixpkgs#pandoc nixpkgs#texlive.combined.scheme-full -c pandoc \
    --from=markdown --output=generics-sop-intro.pdf generics-sop-intro.md  \
    -V geometry:"margin=2cm" \
    -V linkcolor:blue \
    -V geometry:a4paper \
    --toc \
    --include-in-header inline_code.tex \
    --highlight-style pygments.theme
