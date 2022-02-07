#!/bin/bash
set -euo pipefail

has_failed=0

function error() {
  has_failed=1
  >&2 echo ${@}
}

# Go through all test dirs
for d in ./*
do
  # Only read directories
  if [ ! -d "$d" ]
  then
    continue
  fi

  schema="${d}/schema.yaml"

  # Test that should fail
  for t in $d/invalid*
  do
    if ../entrypoint.sh "$schema" "$t"
    then
      error "Test should have failed: $t"
    fi
  done

  # Test that should succeed
  for t in $d/valid*
  do
    if ! ../entrypoint.sh "$schema" "$t"
    then
      error "Test should have passed: $t"
    fi
  done
done

if [ $has_failed -eq 1 ]
then
  error "Some tests failed"
  exit 1
fi

echo "Done!"
