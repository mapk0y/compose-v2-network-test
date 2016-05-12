#!/bin/bash
# vi: set ft=sh et ts=2 sw=2 sts=0:

for i in $(find . -type f -name '*.yml' -print| sort); do
  echo "=== ${i} ==="
  docker-compose -f ${i} up
  docker-compose -f ${i} rm -f --all
done

