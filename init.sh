#!/bin/bash

chmod +x ./sync-config.sh
./sync-config.sh
git config --local core.hooksPath .githooks/

