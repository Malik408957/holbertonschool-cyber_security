#!/bin/bash
cut -d " " -f8 auth.log | sort | uniq -c  | sort -nr
