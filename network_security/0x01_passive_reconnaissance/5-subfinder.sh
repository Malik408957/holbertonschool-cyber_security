#!/bin/bash
subfinder -d $1 -silent -nW -oI -o $1.txt | tee >(while read -r host; do ip=$(dig +short "$host" | head -n1); printf "%s,%s\n" "$host" "${ip:-}"; done > tmp && mv tmp "$1.txt")
