#!/bin/bash
set -x

RUN_NPM_START=$1
CYPRESS_HEADLESS=$2
CYPRESS_BROWSER=$3
RUN_JSON_SERVER=$4
JSON_SERVER_PORT=$5
JSON_SERVER_DB=$6
JSON_SERVER_ROUTES=$7

export CY_CLI=true

npm install

if $RUN_NPM_START ; then
  npm start & # Open server in background
  npx wait-on -t 300000 $wait_for_url # wait for server until timeout
fi

if $RUN_JSON_SERVER ; then
  npx json-server-auth --watch $JSON_SERVER_DB -r $JSON_SERVER_ROUTES --port $JSON_SERVER_PORT --delay 1500 &
  npx wait-on -t 300000 http://localhost:$JSON_SERVER_PORT
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

echo "result=`cat result.json | base64 -w 0`" >> $GITHUB_OUTPUT
