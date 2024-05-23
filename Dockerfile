# See https://stackoverflow.com/a/72291691/2427596
FROM node:current-alpine

LABEL org.opencontainers.image.source https://github.com/unfoldingWord/door43-preview-server

USER root

RUN apk add chromium

# https://github.com/Yelp/dumb-init
RUN apk update && apk add dumb-init

WORKDIR /app
ADD . .
RUN npm install -y && npm run build

EXPOSE 3000

ENTRYPOINT ["dumb-init", "--"]

CMD ["node", "-e", "require('./dist/server.js').use(require('puppeteer-core'))"]
