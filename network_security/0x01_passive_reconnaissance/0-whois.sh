#!/bin/bash
whois -h whois.gandi.net $1 | awk -F':' 'BEGIN{OFS=","} /^Registrant|^Admin|^Tech/{s=$1; sub(/ .*/,"",s)} /^[[:space:]]+[A-Z][a-zA-Z/ -]+:/ && s{gsub(/^[[:space:]]+|[[:space:]]+$/,"",$0); split($0,a,":"); f=s" "a[1]; if(a[1]~/Street/) a[2]=a[2]" "; if(a[1]!~/Name Server|URL|DNSSEC|>>>|https/) print f,a[2]}' > "${1}.csv"
