FROM node:11 as build-deps
WORKDIR /usr/src/app
COPY package.json yarn.lock ./
RUN yarn
COPY . ./
RUN yarn build


FROM nginx:1.15.2-alpine
COPY --from=build-steps usr/src/app/build /var/www
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
ENTRYPOINT ["nginx","-g","daemon off;"]