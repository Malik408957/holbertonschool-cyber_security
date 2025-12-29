#!/usr/bin/env bash
nmap -sM -p 21,22,23,80,443 "$1"
