#!/bin/bash
cut -d' ' -f6- $1 | tr -s ' ' '\n' | sort | uniq -c | sort -rn
