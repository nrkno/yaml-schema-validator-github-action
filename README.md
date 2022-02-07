# yaml-schema-validator-github-action

A GitHub action that uses [Yamale][] for YAML schema validation.

## Usage

- Filenames are relative to the repository root.
- Disable strict checking by setting `no-strict` to `true`, `1` or `yes`.
- For help with the schema definitions and reference, see [Yamale][].

The following example sets up a check to validate a YAML file in your
repository, *target.yaml*, using a schema defined in *schemas/schema.yaml*:

```
name: YAML schema validator
on: [push]

jobs:
  yaml-schema-validation:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: nrkno/yaml-schema-validator-github-action@v4
      with:
        schema: schemas/schema.yaml
        target: target.yaml
        # Uncomment to disable strict checks
        # no-strict: true
```

## Versioning

This action is meant to be a wrapper around Yamale, so as of version 4.x
of Yamale, this action will follow Yamale's major version scheme.

To bind the action to a specific release, suffix with `@<tag>`.
E.g. `nrkno/yaml-schema-validator-github-action@v4`.

https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idstepsuses

## Developing

Create and enable a Python virtualenv

```
$ python -m venv venv
$ source venv/bin/activate
```

Install dependencies

```
$ pip install -r requirements.txt
```

Do a test-run with one of the provided examples

```
$ INPUT_SCHEMA=example/schema.yaml \
  INPUT_TARGET=example/file-valid-strict.yaml \
  ./entrypoint.sh
```

[Yamale]: https://github.com/23andMe/Yamale
