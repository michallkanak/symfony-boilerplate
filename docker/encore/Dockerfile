FROM node:22-alpine

WORKDIR /var/www

# Install bash and update npm to latest version
RUN apk add --no-cache bash && \
    npm install -g npm@latest

RUN yarn add \
    @symfony/webpack-encore \
    sass-loader \
    sass \
    --dev

USER node
