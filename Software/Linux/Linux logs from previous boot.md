---
slug: linux-logs-boot
tags: [micro]
date: 2021-01-23
---

On a #[[Linux]] system managed by [systemd], its [Journal] feature manages the logs for everything from kernel to user level services.  These logs can be accessed using the [`journalctl`] command. The particular query of interest is to retrieve kernel logs from the time *before* current boot.

To display all log messages across all services and components, but since the current boot:

```bash
journalctl -b
```

The `-b` arguments specifies the boot ID, which can be obtained from the first column of the output of `journalctl --list-boots`. The current boot's ID is 0, and the previous boot's ID is -1, and so on. 

If you just did a **cold reboot following a system crash**, you get the logs prior to crash by retrieving the logs for boot ID -1:

```bash
journalctl -b -1
```

Be warned that this displays logs from *all* components and services. Typically to investigate a system crash you only need the kernel logs; the `-k` option will filter out everything bug kernel messages.

```bash
journalctl -b -1 -k
```

This will open `less` in which you may press `GG` to go the end of the logs. This can be automated by explicitly piping to `less +G` (whilst forcing colored output on both ends of the pipe):

```bash
SYSTEMD_COLORS=1 journalctl -b -1 -k | less +G -r
```

Use `j` and `k`, as well as `Ctrl+U` and `Space`, to page through the logs.

[systemd]: https://wiki.archlinux.org/index.php/systemd
[Journal]: https://wiki.archlinux.org/index.php/Systemd/Journal
[`journalctl`]: https://www.loggly.com/ultimate-guide/using-journalctl/
