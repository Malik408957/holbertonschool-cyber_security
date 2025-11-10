#!/bin/bash
subfinder -d $1 -silent | tee >(xargs -I {} sh -c 'echo {},$(dig +short {} | head -1)' > "${1}.txt")
