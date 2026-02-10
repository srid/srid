---
slug: ghcid
---

`ghcid` is advertisied as "a very low feature GHCi based IDE". When one uses `ghcid`, Haskell's lack of formal IDE support becomes less of an issue; because `ghcid` provides the most important feature of instant-recompilation feedback, all in the terminal.

<https://github.com/ndmitchell/ghcid>

## Zombie processes with [[process-compose]] {#zombie}

When running ghcid under [[process-compose]], the child GHC process (i.e., the backend server) can survive after process-compose exits, leaving the port bound. This happens because process-compose sends `SIGTERM` (15) by default, which ghcid does **not** forward to its child GHC process.

**Fix:** Configure `shutdown.signal = 2` (SIGINT) on the ghcid process in process-compose. SIGINT causes ghcid to terminate gracefully along with its children.

```yaml
backend:
  command: "ghcid ..."
  shutdown:
    signal: 2  # SIGINT — ensures child GHC process is terminated
```

In [[Nix]] (using [process-compose-flake](https://github.com/Platonic-Systems/process-compose-flake)):

```nix
backend = {
  command = "ghcid ...";
  shutdown.signal = 2;
};
```

#[[Haskell]]