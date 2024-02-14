FROM node:20-slim

WORKDIR /app

COPY . .

SHELL [ "/bin/bash", "-c" ]

RUN npm ci
RUN npm run generate

FROM nginx:1.21.1-alpine

ADD ./nginx/default.conf /etc/nginx/conf.d/default.conf

COPY --from=0 /app/dist /srv
