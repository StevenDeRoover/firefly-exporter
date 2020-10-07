#!/bin/sh

echo Running nginx
nginx
echo Running node api
node /var/www/server/index.js 