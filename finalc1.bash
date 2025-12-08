#!/bin/sh

curl -s "http://10.0.17.47/IOC.html" \
| hxnormalize -x \
| xmlstarlet sel -t -m "//table//tr//td" -v "." -n
