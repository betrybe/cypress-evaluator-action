FROM cypress/browsers:node18.14.2-chrome99-ff97

COPY entrypoint.sh /entrypoint.sh
COPY evaluator.js /evaluator.js

ENTRYPOINT [ "/entrypoint.sh" ]
