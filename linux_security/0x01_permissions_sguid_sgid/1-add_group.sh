#!/bin/bash
addgroup "$1"
chown $(whoami) "$2"; chgrp "$1" "$2"
chmod g+rx "$2"
