#!/bin/bash 
grep useradd "auth.log"|cut -d" " -f8|sort|cut -d"=" -f2|tr -d '\n'
