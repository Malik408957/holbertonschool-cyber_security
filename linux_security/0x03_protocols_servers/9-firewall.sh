#!/bin/bash
sudo iptables -A INPUT -p tcp --dport ssh -s $1 -j ACCEPT
sudo iptables -A INPUT -j DROP
