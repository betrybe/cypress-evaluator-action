FROM cypress/browsers:node12.13.0-chrome78-ff70
# FROM node:12.14

COPY entrypoint.sh /entrypoint.sh
COPY evaluator.js /evaluator.js

ENTRYPOINT [ "/entrypoint.sh" ]
