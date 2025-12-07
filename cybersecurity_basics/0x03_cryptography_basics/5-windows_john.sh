#!/bin/bash
john --wordlist=/usr/share/wordlists/rockyou.txt --format=nt "$1"
john --show --format=nt "$1" \
    | grep -E ":[^:]+$" \
    | cut -d: -f2 \
    | sed 's/^[ \t]*//;s/[ \t]*$//' > 5-password.txt
