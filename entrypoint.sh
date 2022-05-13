#!/bin/bash
set -eux

if [ "${INPUT_NO_STRICT}" = "true" ]
then
  no_strict='--no-strict '
fi

yamale "${no_strict}"
