#!/bin/bash
[ -z "$1" ] && echo "Usage: $0 <subnet>" && exit 1 || sudo nmap -sn -PR $1
