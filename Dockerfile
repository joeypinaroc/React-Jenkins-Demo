# FROM node:20.11.0-bullseye
# RUN npm install -g netlify-cli

# for aws deployment
FROM nginx:1.27-alpine
COPY build /usr/share/nginx/html