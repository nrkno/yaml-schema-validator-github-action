#!/bin/bash
set -e

# Returns a string `true` if the string is considered boolean true,
# otherwise `false`. An empty value is considered false.
function str_bool {
  local str="${1:-false}"
  local pat='^(true|1|yes)$'
  if [[ "$str" =~ $pat ]]; then
    echo 'true'
  else
    echo 'false'
  fi
}

schema="$INPUT_SCHEMA"
target_path_glob="$INPUT_TARGET_PATH_GLOB"
no_strict=$(str_bool "${INPUT_NO_STRICT:-}")
error_is_success=$(str_bool "${INPUT_ERROR_IS_SUCCESS:-}")

# check schema
if [ ! -e "${schema}" ]; then
  echo >&2 "Schema does not exist: $schema"
  exit 1
fi

# check target input
matching_files=()
# Split the INPUT_TARGET into an array using comma as the delimiter
IFS=',' read -ra targets <<<"$INPUT_TARGET"

for target in "${targets[@]}"; do
  if [ ! -e "${target}" ]; then
    echo "warnig: no match found for $target"
  else
    matching_files+=("$target")
  fi
done

# check glob and add matched files
while IFS='' read -r file; do matching_files+=("$file"); done < <(find . -path "${target_path_glob}" -print)

# Check if any matching files were found
if [ "${#matching_files[@]}" -eq 0 ]; then
  echo >&2 "No matching files found for target: $target"
  exit 1
fi
# done checking target inputs

# Must end with a space here
extra_args=' '

if [ "$no_strict" = "true" ]; then
  extra_args='--no-strict '
fi

if [ "$error_is_success" = "true" ]; then
  # Flipped validation logic
  echo "--- Flipped validation logic enabled (error-is-success: true)! ---"
  for file in "${matching_files[@]}"; do
    # shellcheck disable=SC2086
    yamale $extra_args --schema="${schema}" "$file" && exit 1
  done
  exit 0
fi

# Normal execution
for file in "${matching_files[@]}"; do
  # shellcheck disable=SC2086
  yamale $extra_args --schema="${schema}" "$file"
done
