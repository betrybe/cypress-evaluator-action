# cypress-evaluator-action
Cypress evaluator action for Tryber projects

This action evaluate Tryber projects with [Cypress](https://www.npmjs.com/package/cypress) library.

## Inputs

### `npm-start`

**Default: false**

Run npm start and waits to http://localhost:3000 before testing

### `headless`

**Default: true**

Hide the browser instead of running headed at Cypress running

### `browser`

**Default: "chrome"**

Define what browser Cypress must run

### `pr_author_username:

**Required**

Pull Request author username

## Outputs

### `result`

Cypress unit tests JSON results in base64 format.

## Simple usage example
```yml
uses: betrybe/cypress-evaluator-action@v6
```

## How to get result output
```yml
- name: Cypress evaluator
  id: evaluator
  uses: betrybe/cypress-evaluator-action@v6
- name: Next step
  uses: another-github-action
  with:
    param: ${{ steps.evaluator.outputs.result }}
```

## Project constraints

The project that wants to use this action should implement unit tests grouping them using `describe` statements.
Each `describe` statement **will be mapped to a requirement**.

Example:

```javascript
describe('requirement #1' () => {
  it('unit test1', () => {});
  it('unit test2', () => {});
  it('unit test3', () => {});
});

describe('requirement #2' () => {
  it('unit test1', () => {});
  it('unit test2', () => {});
  it('unit test3', () => {});
});

describe('requirement #3' () => {
  it('unit test1', () => {});
  it('unit test2', () => {});
  it('unit test3', () => {});
});
```

Project repository must create a file called `requirements.json` inside `.trybe` folder.

This file should have the following structure:

```json
{
  "requirements": [{
    "description": "requirement #1",
    "bonus": false
  }, {
    "description": "requirement #2",
    "bonus": true
  }, {
    "description": "requirement #3",
    "bonus": false
  }]
}
```

where the `"requirement #1"`, `"requirement #2"` and `"requirement #3"` are the requirements and describes names.

## Learn about GitHub Actions

- https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-a-docker-container-action
