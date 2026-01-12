#!/bin/bash
cat dos.logs | cut -d " " -f1 | sort | uniq -c | sort -nr|head -1 |awk '{print $1}'
