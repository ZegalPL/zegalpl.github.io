FROM nginx:alpine
LABEL maintainer="SAIL-IT.PRO"
EXPOSE 80
COPY ./ /usr/share/nginx/html