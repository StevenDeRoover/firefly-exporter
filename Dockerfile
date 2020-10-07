FROM node:12.18.4-alpine3.10 AS build-steps
WORKDIR /usr/src/app
COPY ./app/package.json ./app/yarn.lock ./
RUN yarn
COPY ./app ./
RUN yarn build

FROM node:12.18.4-alpine3.10 AS build-server
WORKDIR /usr/src/api
COPY ./api/package.json ./api/yarn.lock ./
CMD cat package.json
RUN yarn
COPY ./api ./
RUN yarn build
#RUN yarn add global typescript
#RUN yarn install

RUN npx tsc

FROM nginx:1.19.3-alpine
RUN apk add --update nodejs npm
COPY --from=build-steps usr/src/app/build /var/www
COPY --from=build-server usr/src/api/build /var/www/server/
COPY nginx.conf /etc/nginx/nginx.conf
COPY ./start.sh /usr/bin/
EXPOSE 80
EXPOSE 3080
ENTRYPOINT ["/usr/bin/start.sh"] 