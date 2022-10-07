#!/usr/bin/env bash

docker-compose run --rm server create_db

echo "You can now run 'docker-compose up -d'"
