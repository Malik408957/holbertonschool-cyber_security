#!/bin/bash
grep "new user" auth.log | cut -d '=' -f 2 | cut -d ',' -f 1 | sort -u | paste -sd "," -
