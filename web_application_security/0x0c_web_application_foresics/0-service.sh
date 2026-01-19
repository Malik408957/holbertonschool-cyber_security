#!/bin/bash
cut -d " " -f4 auth.log | sort | uniq -c  | sort -nr
