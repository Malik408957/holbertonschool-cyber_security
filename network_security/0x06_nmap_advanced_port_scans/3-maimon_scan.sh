#!/bin/bash
nmap -sM -Pn -p 21,22,23,80,443 "$1"
