#!/usr/bin/python3
import sys
import os

"""
Module to read and write to the heap of a running process.
This script finds a search string in the heap and replaces it with a replace string.
"""

def main():
    """
    Main function to parse arguments, find the heap, search for the string,
    and replace it if found.
    """
    if len(sys.argv) != 4:
        print("Usage: read_write_heap.py pid search_string replace_string")
        sys.exit(1)

    try:
        pid = int(sys.argv[1])
    except ValueError:
        print("Invalid PID: must be an integer")
        sys.exit(1)

    search_str = sys.argv[2]
    replace_str = sys.argv[3]

    search = search_str.encode('ascii')
    replace = replace_str.encode('ascii') + b'\x00'  # Add null terminator for C strings

    # Find heap address range from /proc/<pid>/maps
    maps_path = f"/proc/{pid}/maps"
    try:
        with open(maps_path, 'r') as maps_file:
            heap_start = None
            heap_end = None
            for line in maps_file:
                if '[heap]' in line:
                    parts = line.split()
                    addr_range = parts[0]
                    start_hex, end_hex = addr_range.split('-')
                    heap_start = int(start_hex, 16)
                    heap_end = int(end_hex, 16)
                    break
            if heap_start is None:
                print("Heap region not found in process maps")
                sys.exit(1)
    except FileNotFoundError:
        print(f"Process with PID {pid} not found")
        sys.exit(1)

    # Open /proc/<pid>/mem for read/write
    mem_path = f"/proc/{pid}/mem"
    try:
        mem_file = os.open(mem_path, os.O_RDWR)
    except PermissionError:
        print("Permission denied: Run with sudo for memory access")
        sys.exit(1)
    except FileNotFoundError:
        print(f"Memory file for PID {pid} not found")
        sys.exit(1)

    # Seek to heap start and read heap data
    os.lseek(mem_file, heap_start, os.SEEK_SET)
    heap_size = heap_end - heap_start
    heap_data = os.read(mem_file, heap_size)

    # Find the search string in heap
    offset = heap_data.find(search)
    if offset == -1:
        print(f"String '{search_str}' not found in heap")
        os.close(mem_file)
        sys.exit(0)  # Success, but not found - exit 0

    # Calculate absolute address
    address = heap_start + offset
    print(f"Found '{search_str}' at address 0x{address:x}")

    # Seek to the found position and write replacement
    os.lseek(mem_file, address, os.SEEK_SET)
    os.write(mem_file, replace)
    print(f"Replaced with '{replace_str}'")

    os.close(mem_file)

if __name__ == "__main__":
    main()
