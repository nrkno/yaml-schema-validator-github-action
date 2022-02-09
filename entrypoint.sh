#!/bin/bash
set -eux

echo '::warning::The version nrkno/yaml-schema-validator-github-action@master is a deprecated version of this action which contains a security vulnerability. Please update to nrkno/yaml-schema-validator-github-action@v4 and check out the repository for more information.'

strict=''
schema=${INPUT_SCHEMA:-$1}
target=${INPUT_TARGET:-$2}

if [ -n "${INPUT_STRICT:-}" ]
then
  strict='--strict'
fi

if [ ! -e ${schema} ]
then
  >&2 echo "Schema does not exist: $schema"
  exit 1
fi

if [ ! -e ${target} ]
then
  >&2 echo "Target does not exist: $target"
  exit 1
fi

yamale --schema=${schema} $target $strict
