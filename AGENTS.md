# AGENTS.md

Guidance for coding agents working on `refp`.

## Project purpose

`refp` is a reference playground for reverse-engineering browser fingerprinting scripts. Keep examples small, reproducible, and easy to compare against `visiblev8` traces and idealized decompiler output.

## Example layout

Put specimens under `examples/<nn-short-name>/`. A basic example should contain:

- `index.html` — self-contained target page that loads `source.js`.
- `source.js` — the script to trace; keep it simple and commented.
- `ideal.linear.js` — ground-truth linear JavaScript reconstruction.
- `README.md` — short explanation and file structure.

Generated traces live in `examples/<example>/trace/`. These directories are ignored by git; do not commit or force-add them unless project policy changes. The old `trace.vv8.log` placeholder convention is no longer used.

## Trace generation

Use the root script:

```sh
scripts/run-vv8.sh 00-navigator-useragent
scripts/run-vv8.sh --local 00-navigator-useragent
```

The script writes raw visiblev8 logs to the example’s ignored `trace/` directory.

## Style conventions

- Keep examples minimal and deterministic.
- Prefer plain classic browser scripts unless an example specifically needs modules.
- Avoid external assets or network dependencies in examples.
- Result displays should show only the JSON payload, not labels like `result:`.
- Use `<pre id="result">Waiting...</pre>` for pretty-printed JSON output.

## Trace marker convention

For examples using start/end markers, the calls themselves are the trace markers:

```js
document.getElementById('refp-start');
// payload
document.getElementById('refp-end');
```

Do not add actual `refp-start` or `refp-end` elements to the HTML unless a specific test requires them.

## Documentation

When adding an example, update:

- root `README.md` with a tiny one-line description;
- the manually maintained root `index.html` examples table;
- the example’s own `README.md`.

Before committing, check `git status --short` and avoid sweeping unrelated local changes into the commit.
