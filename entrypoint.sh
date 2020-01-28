#!/bin/sh -l

git clone https://github.com/$GITHUB_REPOSITORY-tests.git /project-tests
rm -rf /project-tests/.git
cp -r /project-tests/* .
npm install
node_modules/.bin/cypress run
ls -lah
ls -lah cypress/reports
node /evaluator.js cypress/reports/mochawesome.json requirements_mapping.json result.json

if [ $? != 0 ]; then
  echo "Execution error"
  exit 1
fi

# echo "::set-output name=pr-number::$(echo "$GITHUB_REF" | awk -F / '{print $3}')"
# echo "::set-output name=result::`cat result.json | base64 -w 0`"

echo "::set-output name=pr-number::1"
echo "::set-output name=result::blablabla"
