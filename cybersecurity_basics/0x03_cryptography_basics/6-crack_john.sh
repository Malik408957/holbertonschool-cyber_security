#!/bin/bash
john --show --format=raw-sha256 "$1" | grep -E "^[^:]+:[^:]+$" | cut -d: -f2 > 6-password.txt
