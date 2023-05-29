#!/bin/bash

while inotifywait -r -e modify,create,delete ./app; do
  docker-compose up -d app
done