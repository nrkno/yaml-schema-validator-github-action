#!/bin/bash
set -eux

# Returns a string `true` the string is considered boolean true,
# otherwise `false`. An empty value is considered false.
function str_bool {
  local str="${1:-false}"
  local pat='^(true|1|yes)$'
  if [[ "$str" =~ $pat ]]
  then
    echo 'true'
  else
    echo 'false'
  fi
}

schema="$INPUT_SCHEMA"
target="$INPUT_TARGET"
no_strict=$(str_bool "${INPUT_NO_STRICT:-}")
error_is_success=$(str_bool "${INPUT_ERROR_IS_SUCCESS:-}")

# Must end with a space here
extra_args=' '

if [ ! -e "${schema}" ]
then
  >&2 echo "Schema does not exist: $schema"
  exit 1
fi

# TODO: Allow directories
if [ ! -e "${target}" ]
then
  >&2 echo "Target does not exist: $target"
  exit 1
fi

if [ "$no_strict" = "true" ]
then
  extra_args='--no-strict '
fi

if [ "$error_is_success" = "true" ]
then
  # Flipped validation logic
  echo "--- Flipped validation logic enabled (error-is-success: true)! ---"
  # shellcheck disable=SC2086
  yamale $extra_args --schema="${schema}" "$target" && exit 1
  exit 0
fi

# Normal execution
# shellcheck disable=SC2086
yamale $extra_args --schema="${schema}" "$target"
