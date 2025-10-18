#!/bin/bash
sudo ufw allow 80/tcp && sudo ufw deny incoming && sudo ufw enable && echo "Rules updated" && echo "Rules updated (v6)"
