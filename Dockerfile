# Build stage
FROM node:8.11.2-alpine as node

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Serve stage
FROM nginx:1.13.12-alpine

# Copy the built project
COPY --from=node /usr/src/app/dist/angular-ci-test /usr/share/nginx/html

COPY ./nginx.conf /etc/ngix/conf.d/default.conf
