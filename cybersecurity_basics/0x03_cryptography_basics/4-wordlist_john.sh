#!/bin/bash
john --format=dynamic_0 --wordlist=/usr/share/wordlists/rockyou.txt "$1"; john --show --format=dynamic_0 "$1" | cut -d':' -f2 > 4-password.txt
