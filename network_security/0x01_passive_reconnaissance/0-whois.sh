#!/bin/bash
whois "$1" | awk -F: '/^(Registrant|Admin|Tech) / { gsub(/^[ \t]+/, "", $2); field=$1; gsub(/[ \t]+$/, "", field); ext=(field ~ /(Phone|Fax) Ext$/); street=(field ~ /Street$/); val=(length($2)>0 ? $2 : " "); if (street) val=val " "; printf "%s%s,%s\n", field, (ext ? ":" : ""), val }' > "$1".csv
