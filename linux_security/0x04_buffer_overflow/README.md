Project Description
This project demonstrates how to manipulate the memory of a running process by searching for a string in its heap and replacing it. The script read_write_heap.py exploits this by accessing /proc/<pid>/maps and /proc/<pid>/mem to locate and modify the heap data. This is an educational exercise to understand buffer overflows and memory manipulation in Linux processes.
The example uses a simple C program (main.c) that allocates a string "Holberton" on the heap and prints it in an infinite loop. The Python script replaces it with another string (e.g., "maroua").
