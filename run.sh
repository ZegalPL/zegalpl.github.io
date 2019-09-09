#!/bin/bash
docker rm -f website
docker rmi website
docker build -t website .
docker run -d -p 80:80 --name website website
xdg-open http://localhost:80 </dev/null >/dev/null 2>&1 & disown