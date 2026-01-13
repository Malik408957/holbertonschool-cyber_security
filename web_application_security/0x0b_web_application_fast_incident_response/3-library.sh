#!/bin/bash
cut -d " " -f12 logs.txt | sort | uniq -c | sort -nr | head -1 | awk '{print $2}'
