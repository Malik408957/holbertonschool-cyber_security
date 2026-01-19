#!/bin/bash
grep -o "user [a-zA-Z0-9_-]*" auth.log \
| cut -d" " -f2 \
| sort -u \
| tr '\n' ',' \
| sed 's/,$//'
