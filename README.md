# yaml-schema-validator-github-action

A GitHub action that uses [Yamale][] for YAML schema validation.

## Usage

- Disable strict checking by setting `no-strict` to `true`.
- For help with the schema definitions and reference, see [Yamale][].

The following example sets up a check to validate all YAML files in your
repository sibling to a `schema.yaml`:

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
$ ./entrypoint.sh
```

[Yamale]: https://github.com/23andMe/Yamale
