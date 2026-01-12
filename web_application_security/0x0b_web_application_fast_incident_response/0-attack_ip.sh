#!/bin/bash

cut -d " " -f1 $1 | sort | uniq -c | sort -nr | head -1 | awk '{print $2}'
