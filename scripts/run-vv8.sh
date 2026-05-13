#!/bin/sh

set -eu

usage() {
  cat <<'USAGE'
Usage: scripts/run-vv8.sh [--local] <example>

Generate visiblev8 traces for an example.

Arguments:
  <example>  Example name or path, e.g. 00-navigator-useragent
             or examples/00-navigator-useragent

Options:
  --local    Use http://host.docker.internal:8000/ instead of GitHub Pages
  -h, --help Show this help message
USAGE
}

fail() {
  echo "Error: $1" >&2
  echo >&2
  usage >&2
  exit 1
}

script_dir=$(dirname "$0")
repo_root=$(CDPATH= cd "$script_dir/.." && pwd)

use_local=0
example_arg=

while [ "$#" -gt 0 ]; do
  case "$1" in
    -h|--help)
      usage
      exit 0
      ;;
    --local)
      use_local=1
      ;;
    -*)
      fail "unknown option: $1"
      ;;
    *)
      if [ -n "$example_arg" ]; then
        fail "unexpected extra argument: $1"
      fi
      example_arg=$1
      ;;
  esac
  shift
done

if [ -z "$example_arg" ]; then
  fail "missing example argument"
fi

while [ "${example_arg%/}" != "$example_arg" ]; do
  example_arg=${example_arg%/}
done

case "$example_arg" in
  examples/*)
    example_name=${example_arg#examples/}
    ;;
  *)
    example_name=$example_arg
    ;;
esac

case "$example_name" in
  ''|'.'|'..'|*/*)
    fail "invalid example: $example_arg"
    ;;
esac

example_dir=$repo_root/examples/$example_name
trace_dir=$example_dir/trace

if [ ! -d "$example_dir" ]; then
  fail "example directory not found: examples/$example_name"
fi

if [ ! -f "$example_dir/index.html" ]; then
  fail "example is missing index.html: examples/$example_name"
fi

if [ "$use_local" -eq 1 ]; then
  base_url=http://host.docker.internal:8000
else
  base_url=https://infosimples.github.io/refp
fi

target_url=$base_url/examples/$example_name/

rm -rf "$trace_dir"
mkdir -p "$trace_dir"

echo "Target URL: $target_url"
echo "Trace output: $trace_dir"

docker run \
  -v "$trace_dir:/trace" \
  -w /trace \
  visiblev8/vv8-base:latest \
  --no-sandbox \
  --headless \
  --virtual-time-budget=30000 \
  --user-data-dir=/tmp \
  --disable-dev-shm-usage \
  "$target_url"
