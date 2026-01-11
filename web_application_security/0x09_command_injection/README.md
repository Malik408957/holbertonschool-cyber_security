Project Description
This project demonstrates a command injection vulnerability in a web application, specifically in the ping functionality of an Asset Discovery tool. The goal is to identify and exploit the vulnerability to read the flag file located at /0-flag.txt. This is an educational exercise to understand how improper input sanitization can lead to arbitrary command execution on the server.
The target application is hosted at http://web0x09.hbtn-task0/, and the vulnerability allows injecting system commands via separators like ;, &&, or
