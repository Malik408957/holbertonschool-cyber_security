#!/bin/bash
cut -d " " -f5 auth.log | sort | uniq -c  | sort -nr
