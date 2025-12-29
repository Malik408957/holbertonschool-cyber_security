#!/bin/bash
nmap -sM --reason -p 21,22,23,80,443 "$1"
