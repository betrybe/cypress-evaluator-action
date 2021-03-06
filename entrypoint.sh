#!/bin/bash
set -x

RUN_NPM_START=$1
CYPRESS_HEADLESS=$2
CYPRESS_BROWSER=$3

npm install

if $RUN_NPM_START ; then
  npm install -g wait-on
  npm start & wait-on http://localhost:3000
fi

headless_flag=''
if $CYPRESS_HEADLESS ; then
  headless_flag="--headless"
fi

node_modules/.bin/cypress install
node_modules/.bin/cypress run "$headless_flag" --browser "$CYPRESS_BROWSER"
ls
node_modules/.bin/mochawesome-merge cypress/reports/*.json > output.json
ls
node /evaluator.js output.json .trybe/requirements.json result.json

if [ $? != 0 ]; then
  echo "Execution error"
  exit 1
fi

echo "::set-output name=result::`cat result.json | base64 -w 0`"
