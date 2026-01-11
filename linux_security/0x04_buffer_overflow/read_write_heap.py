#!/usr/bin/python3
import sys
import os

if len(sys.argv) != 4:
    print("Usage: read_write_heap.py pid search_string replace_string")
    sys.exit(1)

pid = sys.argv[1]
search = sys.argv[2].encode()
replace = sys.argv[3].encode() + b'\x00'

try:
    with open(f"/proc/{pid}/maps") as f:
        for line in f:
            if "[heap]" in line:
                start, end = line.split()[0].split('-')
                start = int(start, 16)
                end = int(end, 16)
                break
        else:
            sys.exit(1)

    mem = os.open(f"/proc/{pid}/mem", os.O_RDWR)
    os.lseek(mem, start, os.SEEK_SET)
    data = os.read(mem, end - start)

    i = data.find(search)
    if i != -1:
        os.lseek(mem, start + i, os.SEEK_SET)
        os.write(mem, replace)

    os.close(mem)

except Exception:
    sys.exit(1)
