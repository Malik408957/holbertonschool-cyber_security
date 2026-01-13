#!/bin/bash
cat dos.logs | cut -d ' ' -f10  | uniq -c |sort -nr|head -1| awk -F\" '{print $2}'
