#!/bin/bash
[ "$EUID" -ne 0 ] && echo "Error: Run as root/sudo" && exit 1; ! command -v tcpdump &> /dev/null && apt-get update && apt-get install -y tcpdump; tcpdump -c 5 -i any
