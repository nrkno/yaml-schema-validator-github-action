#!/bin/bash
set -ex

strict=''

if [ -n "${INPUT_STRICT}" ]
then
  strict='--strict'
fi

yamale --schema ${INPUT_SCHEMA:-$1} ${INPUT_VALIDATION:-$2} $strict
