#!/bin/bash

set -ev
RED='\033[0;31m'
NC='\033[0m' # No Color
GREEN='\033[0;32m'

if [ "${TRAVIS_PULL_REQUEST}" = "false" ]; then
  git clone "https://github.com/$TRAVIS_REPO_SLUG.git" "$TRAVIS_REPO_SLUG"
  cd "$TRAVIS_REPO_SLUG"
  git checkout master
  git checkout -qf "$TRAVIS_COMMIT"
fi

chef exec rake except_kitchen
coverage=$(jq '.["result"]["covered_percent"]' coverage/.last_run.json)
if [ "$coverage" -lt 100 ]; then
  echo -e "${RED} Coverage:${coverage}, please add tests ${NC}"
else
  echo -e "${GREEN} Coverage:${coverage}, Great Job ${NC}"
fi
