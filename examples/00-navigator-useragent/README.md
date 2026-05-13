# 00-navigator-useragent

Example of a trivial fingerprinting script that just reads the property `navigator.userAgent`.

## Ideal output of a reverse engineering tool

```js
var out = { userAgent: navigator.userAgent };
```

## Generate traces

From the repository root:

```sh
scripts/run-vv8.sh 00-navigator-useragent
```
