#!/bin/bash
ps aux | grep "^$1" | grep -v "VSZ..0..RSS..0"
