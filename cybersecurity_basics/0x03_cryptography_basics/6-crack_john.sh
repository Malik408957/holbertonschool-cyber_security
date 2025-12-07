#!/bin/bash
john --format=raw-sha256 "$1" --show > 6-password.txt
