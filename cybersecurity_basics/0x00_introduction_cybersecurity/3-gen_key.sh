#!/bin/bash

# Check if a filename was provided as an argument
if [ $# -eq 0 ]; then
    echo "Error: Please provide a key filename"
    echo "Usage: $0 <key_filename>"
    exit 1
fi

# Set the key filename from the first argument
KEY_FILENAME="$1"

# Generate RSA SSH key pair with 4096 bits
ssh-keygen -t rsa -b 4096 -f "$KEY_FILENAME" -N ""

# Check if key generation was successful
if [ $? -eq 0 ]; then
    echo "SSH key pair generated successfully:"
    echo "Private key: $KEY_FILENAME"
    echo "Public key: ${KEY_FILENAME}.pub"
else
    echo "Error: Failed to generate SSH key pair"
    exit 1
fi
