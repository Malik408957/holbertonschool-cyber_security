#!/bin/bash
cut -d " " -f9 auth.log | sort | uniq -c  | sort -nr
