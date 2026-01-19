#!/bin/bash
grep "pam_unix" auth.log \
| cut -d '(' -f2 \
| cut -d ':' -f1 \
| sort \
| uniq -c \
| sort -rn
