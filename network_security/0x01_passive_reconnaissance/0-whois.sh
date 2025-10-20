#!/bin/bash
whois -h whois.gandi.net "$1" | awk -F':' '/Registrant Name:/{s="Registrant"} /Admin Name:/{s="Admin"} /Tech Name:/{s="Tech"} s && /^ *[A-Z][a-zA-Z\/ -]+:/{gsub(/^ +| +$/,"",$1);gsub(/^ +| +$/,"",$2);if($1!~/Name Server|URL|DNSSEC/&&$2)print s" "$1","($1~/Street/?$2" ":$2)}' > "${1}.csv"
