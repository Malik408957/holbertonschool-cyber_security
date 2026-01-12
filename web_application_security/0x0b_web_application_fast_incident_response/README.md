# 0x0b Web Application Fast Incident Response - Identify Attack Source

## Project Description
This project creates a Bash script to analyze a log file and identify the IP address with the most requests, potentially indicating a DoS attack source.

## Requirements
- Tested on Kali Linux.
- Editors: vi, vim, emacs.
- Files end with new line.
- Script starts with #!/bin/bash.
- No backticks, &&, ||, ;.
- Executable files.
- Use $1 without quotes for the log file.

## Files
- `0-attack_ip.sh`: The Bash script to find the top IP.
- `logs.txt`: Sample log file (not included in repo, for testing).
