#!/bin/bash
john --wordlist=/usr/share/wordlists/rockyou.txt --format=raw-md5 "$1" --pot=john.pot 2>/dev/null
john --show "$1" --pot=john.pot 2>/dev/null | grep : | cut -d: -f2 > 4-password.txt
