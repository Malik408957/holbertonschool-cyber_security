#!/bin/bash
whois "$1" | awk -F':' 'BEGIN{OFS=","} /[Rr]egistrant/&&!/[Rr]egistrar/{s="Registrant"} /[Aa]dmin/&&!/[Rr]egistrar/{s="Admin"} /[Tt]ech/&&!/[Rr]egistrar/{s="Tech"} s&&/^[ ]*[A-Z][a-zA-Z\/ -]+:/&&NF>=2{gsub(/^[ ]+|[ ]+$/,"",$1);gsub(/^[ ]+|[ ]+$/,"",$2);if($1!~/Name Server|URL|DNSSEC|Registrar|>>>/&&$2!="")print s" "$1,($1~/Street/)?$2" ":$2}' > "${1}.csv"
