# cypress-evaluator-action
Cypress evaluator action for Tryber projects

This action evaluate Tryber projects with [Cypress](https://www.npmjs.com/package/cypress) library.

## Inputs

### `repository-test-name`

**Required**

GitHub repository that store the tests

### `repository-test-branch`

**Required**

**Default: "master"**

GitHub specific branch

### `npm-start`

**Default: false**

Run npm start and waits to http://localhost:3000 before testing

## Outputs

### `result`

Cypress unit tests JSON results in base64 format.

### `pr-number`

Pull Request number that trigger build.

## Simple usage example
```yml
uses: betrybe/cypress-evaluator-action
```

## How to get result output
```yml
- name: Cypress evaluator
  id: evaluator
  uses: betrybe/cypress-evaluator-action
- name: Next step
  uses: another-github-action
  with:
    param: ${{ steps.evaluator.outputs.result }}
```

## Project contraints

The project that want to use this action should keep a file called `requirements_mapping.json` in root folder with this structure:

```json
{
  "test-name-1": 17,
  "unit test 2 name": 36,
}
```

where `"test-name-1"` and `"unit test 2 name"` are the tests' name and `17` and `36` are the requirements identifiers.

## Learn about GitHub Actions

- https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-a-docker-container-action
