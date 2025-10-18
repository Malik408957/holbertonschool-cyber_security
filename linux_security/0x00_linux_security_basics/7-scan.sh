#!/bin/bash
[ "$EUID" -ne 0 ] && echo "Error: Run as root/sudo" && exit 1; [ -z "$1" ] && echo "Usage: sudo ./7-scan.sh <subnetwork>" && exit 1; ! command -v nmap &> /dev/null && apt-get update && apt-get install -y nmap; nmap -sn "$1"
