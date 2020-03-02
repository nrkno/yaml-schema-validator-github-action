# yaml-schema-validator-github-action

A GitHub action that uses [Yamale][] for YAML schema validation.

## Usage

- Filenames are relative to the repository root.
- Enable strict checking by setting `strict` to a non-empty string.
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
    - uses: nrkno/yaml-schema-validator-github-action@v0.0.1-pre
      with:
        schema: 'schemas/schema.yaml'
        target: 'target.yaml'
        # Uncomment to enable strict checks
        # strict: '1'
```

## Developing

Create and enable a Python virtualenv (not strictly required, but makes testing
more robust)

```
$ python -m venv venv
$ source venv/bin/activate
```

Install dependencies

```
$ pip install -r requirements.txt
```

Do a test-run with the provided examples

```
$ ./entrypoint.sh example/schema.yaml example/file.yaml
```

### Using Docker

Build the container and reference files within the example/ folder.

```
$ docker build -t yaml-schema-validator .
$ docker run yaml-schema-validator example/schema.yaml example/file.yaml
```


[Yamale]: https://github.com/23andMe/Yamale
