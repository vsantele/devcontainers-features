# Promptflow (promptflow)

Add all requirements for a [promptflow](https://github.com/microsoft/promptflow) to your devcontainer.

## Example Usage

```json
"features": {
    "ghcr.io/vsantele/devcontainers-features/promptflow:1": {
        "version": "latest"
    }
}
```

## Options

| Options Id      | Description                                                                  | Type    | Default Value |
| --------------- | ---------------------------------------------------------------------------- | ------- | ------------- |
| version         | version of promptflow package.                                               | string  | latest        |
| toolsVersion    | version of promptflow-tools package.                                         | string  | latest        |
| withVectorDB    | include or not promptflow-vectordb.                                          | boolean | false         |
| vectordbVersion | version of promptflow-vectordb package.                                      | string  | latest        |
| extra           | Add extra packages for ["","azure", "azureml-serving", "executable", "pfd"]. | string  | ""            |

---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/devcontainers/feature-starter/blob/main/src/color/devcontainer-feature.json). Add additional notes to a `NOTES.md`._
