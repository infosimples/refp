# refp - Reverse Engineer Fingerprints Playground

**Reverse Engineer Fingerprints Playground (refp)** is a curated reference dataset of web scripts and browser fingerprinting specimens for testing de-obfuscation and reverse engineering tools.

Browse examples: <https://infosimples.github.io/refp/>

## Overview

Each specimen includes:

- **Target page:** the HTML/JS that executes the fingerprint.
- **Ground truth:** the ideal linear JavaScript reconstruction.
- **Generated traces:** raw `visiblev8` logs written to ignored per-example `trace/` directories.

## Repository Structure

```text
refp/
├── index.html                  # Manually maintained example index
├── scripts/
│   └── run-vv8.sh              # Generate visiblev8 traces for an example
└── examples/
    ├── 00-navigator-useragent/ # Get navigator.userAgent
    └── ...
```

## Generate traces

Trace generation requires Docker. The `visiblev8/vv8-base:latest` image may be pulled on first use.

Generate traces against GitHub Pages:

```sh
scripts/run-vv8.sh 00-navigator-useragent
```

Generate traces against a locally served copy:

```sh
scripts/run-vv8.sh --local 00-navigator-useragent
```

Generated traces are written to `examples/<example>/trace/` and ignored by git.
