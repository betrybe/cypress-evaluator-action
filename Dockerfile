FROM cypress/browsers:node16.14.2-slim-chrome100-ff99-edge

COPY entrypoint.sh /entrypoint.sh
COPY evaluator.js /evaluator.js

ENTRYPOINT [ "/entrypoint.sh" ]
