#!/bin/bash
whois -h whois.gandi.net "$1" | awk -F':' '/Registrant Name:/{s="Registrant";next} /Admin Name:/{s="Admin";next} /Tech Name:/{s="Tech";next} s&&/^ *[A-Z][a-zA-Z\/ -]+:/{gsub(/^ +| +$/,"",$1);gsub(/^ +| +$/,"",$2);if($1!~/Name Server|URL|DNSSEC|Registrar/){f=s" "$1;if($1~/Ext|Fax/&&$1!~/:$/)f=f":";v=($1~/Street/)?$2" ":($2?$2:"");if(f&&v!="")print f","v}}' > "${1}.csv"
