# Task 0 – File Hub (LFI)

## Target
Cyber – WebSec 0x07

## Vulnerable Endpoint
/task0/download_file

## Vulnerable Parameters
- filename
- path

## Exploitation
A Local File Inclusion vulnerability was identified by manipulating the `path`
parameter using directory traversal sequences (`../`).

## Payload Used
filename=0-flag.txt  
path=../../../../etc

## Result
Sensitive local file `/etc/0-flag.txt` was successfully read.
