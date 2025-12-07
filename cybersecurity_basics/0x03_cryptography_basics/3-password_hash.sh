#!/bin/bash
echo -n "$1$(openssl rand -hex 8)" | openssl sha512 | cut -d' ' -f2 > 3_hash.txt
