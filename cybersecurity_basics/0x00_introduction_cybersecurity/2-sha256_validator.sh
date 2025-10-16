#!/bin/bash
computed_hash=$(sha256sum "$1" | cut -d ' ' -f 1)
[ "$computed_hash" = "$2" ] && echo "$1: OK" || echo "$1: FAIL"
