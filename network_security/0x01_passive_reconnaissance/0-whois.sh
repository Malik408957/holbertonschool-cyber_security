#!/bin/bash
whois -h whois.gandi.net "$1" | awk -F':' 'BEGIN{OFS=","} /Registrant Name:/{s="Registrant"} /Admin Name:/{s="Admin"} /Tech Name:/{s="Tech"} /^ *[A-Z]/ && s && NF>1{gsub(/^ +| +$/,"",$1); gsub(/^ +| +$/,"",$2); if($2 && $1!~/Name Server|URL/){f=s" "$1; if($1~/Street/) $2=$2" "; print f,$2}}' > "${1}.csv"
