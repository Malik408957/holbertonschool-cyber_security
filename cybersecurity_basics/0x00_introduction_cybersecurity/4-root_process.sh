#!/bin/bash

# Check if username argument is provided
if [ $# -eq 0 ]; then
    echo "Error: Please provide a username"
    echo "Usage: $0 <username>"
    exit 1
fi

USERNAME="$1"

# Monitor processes for the specified user
# ps aux - show all processes with detailed information
# grep "^$USERNAME" - filter processes owned by the specified user
# grep -v "VSZ..0..RSS..0" - exclude processes with VSZ=0 and RSS=0
ps aux | grep "^$USERNAME" | grep -v "VSZ..0..RSS..0"
