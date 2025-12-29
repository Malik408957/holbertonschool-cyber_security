#!/bin/bash
nmap -sM -Pn -n -p 21,22,23,80,443 "$1"
