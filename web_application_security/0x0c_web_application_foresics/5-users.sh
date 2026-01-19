#!/bin/bash
grep -E "useradd|new user|session opened for user" auth.log \
| sed -n 's/.*user \([a-zA-Z0-9_-]*\).*/\1/p' \
| sort -u \
| tr '\n' ',' \
| sed 's/,$//'
