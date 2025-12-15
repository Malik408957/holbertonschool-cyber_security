#!/bin/bash
hping3 -S --rand-source -p 80 "$1"
