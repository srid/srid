-- Pipeline configuration for Vira <https://vira.nixos.asia/>

\ctx pipeline ->
  pipeline
    { build.systems = 
        [ "x86_64-linux"
        , "aarch64-darwin"
        ]
    , cache.url = Just "https://cache.nixos.asia/oss"
    }
