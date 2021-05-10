FROM cypress/browsers:node14.16.0-chrome89-ff86

COPY entrypoint.sh /entrypoint.sh
COPY evaluator.js /evaluator.js

ENTRYPOINT [ "/entrypoint.sh" ]
