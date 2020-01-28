FROM cypress/browsers:node12.14.0-chrome79-ff71
# FROM node:12.14

COPY entrypoint.sh /entrypoint.sh
COPY evaluator.js /evaluator.js

ENTRYPOINT [ "/entrypoint.sh" ]
