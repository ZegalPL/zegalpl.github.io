#!/bin/bash
# Usage: ./run.sh [podman]   — defaults to docker
ENGINE=${1:-docker}

$ENGINE rm -f website
$ENGINE rmi website 2>/dev/null || true
$ENGINE build -t website .
$ENGINE run -d -p 80:80 --name website website
xdg-open http://localhost:80 </dev/null >/dev/null 2>&1 & disown