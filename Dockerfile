FROM mhart/alpine-node:11 AS builder
WORKDIR /app
COPY . .
RUN yarn global add serve react-scripts typescript
RUN yarn run build

FROM mhart/alpine-node

WORKDIR /app
COPY --from=builder /app/build .
CMD ["serve", "-p", "7078", "-s", "."]
