                                                                   /etc/tmp/finalc3.bash *                                                                     M     
 1 #!/bin/bash
 2
 3 INPUT="/etc/tmp/report.txt"
 4 OUTPUT="/var/www/html/report.html"
 5
 6 awk '
 7 BEGIN {
 8         print "<html><body>"
 9         print "<h3>Access logs with IOC indicators:</h3>"
10         print "<table border=\"1\">"
11 }
12 {
13         printf "<tr><td>%s</td><td>%s</td><td>%s</td></tr>\n", $1, $2, $3
14 }
15 END {
16         print "</table></body></html>"
17 }' "$INPUT" > "$OUTPUT"
18



