#!/bin/bash
grep -E "useradd|new user|pam_unix" auth.log \
| grep -o "user [a-zA-Z0-9_-]*" \
| awk '{print $2}' \
| grep -vE "root|nobody" \
| sort -u \
| tr '\n' ',' \
| sed 's/,$//'
