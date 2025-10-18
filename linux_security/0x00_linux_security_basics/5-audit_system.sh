#!/bin/bash
[ "$EUID" -ne 0 ] && echo "Error: Run as root/sudo" && exit 1; apt-get update && apt-get install -y lynis && lynis audit system --wait
