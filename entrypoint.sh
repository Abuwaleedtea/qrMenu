#!/bin/bash

rm -r qrMenu

git clone https://github.com/Abuwaleedtea/qrMenu.git

/usr/sbin/lighttpd -D -f /etc/lighttpd/lighttpd.conf