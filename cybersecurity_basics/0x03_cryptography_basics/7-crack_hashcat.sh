#!/bin/bash
hashcat -m 0 "$1" /usr/share/wordlists/rockyou.txt --quiet; hashcat --show -m 0 "$1" | cut -d: -f2 > 7-password.txt
