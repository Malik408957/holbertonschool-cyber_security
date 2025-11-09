#!/bin/bash
whois "$1" | awk -F: '/^(Registrant|Admin|Tech) / { gsub(/^[ \t]+/, "", $2); field=$1; gsub(/[ \t]+$$ /, "", field); ext = (field ~ /(Phone|Fax) Ext $$/); printf "%s%s,%s\n", field, (ext ? ":" : ""), (length($2)>0 ? $2 : " ") }' > "$1".csv
