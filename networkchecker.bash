NU nano 6.2                                                                     networkchecker.bash                                                                              
  1 #!/bin/bash
  2 set -x
  3 myIP=$(bash IPBASH.bash)
  4
  5
  6 # Todo-1: Create a helpmenu function that prints help for the script
  7
  8 function helpMenu() {
  9         cat <<EOF
 10 Usage: $0 -n|-s interna;|external
 11
 12 Options:
 13         -n Use nmap to scan ports
 14         -s Use ss to list listening ports
 15
 16 Targets:
 17         internal Scan localhost
 18         external Scan network-visible IP
 19
 20 Examples:
 21         $0 -n external # nmap external interface
 22         $0 -s internal # ss on localhost
 23 EOF
 24 }
 25
 26
 27
 28 # Return ports that are serving to the network
 29 function ExternalNmap(){
 30   rex=$(nmap "${myIP}" | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
 31 }
 32
 33 # Return ports that are serving to localhost
 34 function InternalNmap(){
 35   rin=$(nmap localhost | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
 36 }
 37
 38
 39 # Only IPv4 ports listening from network
 40 function ExternalListeningPorts(){
 41
 42 # Todo-2: Complete the ExternalListeningPorts that will print the port and application
 43 # that is listening on that port from network (using ss utility)
 44
 45 ss -ltpn | awk -F'[:space:(),]+' '!/127\.0\.0\.1/ && !/\[::1\]/ {print $5, $9}' | tr -d '""'
 46 }
 47
 48
 49 # Only IPv4 ports listening from localhost
 50 function InternalListeningPorts(){
 51 ilpo=$(ss -ltpn | awk  -F"[[:space:]:(),]+" '/127.0.0./ {print $5, $9}' | tr -d "\"")
 52 }
 53
 54
 55
 56 # Todo-3: If the program is not taking exactly 2 arguments, print helpmenu
 57 if [ $# -ne 2 ]; then
 58         helpMenu
 59         exit 1
 60 fi
 61
 62
 63 # Todo-4: Use getopts to accept options -n and -s (both will have an argument)
 64 # If the argument is not internal or external, call helpmenu
 65 # If an option other then -n or -s is given, call helpmenu
 66 # If the options and arguments are given correctly, call corresponding functions
 67 # For instance: -n internal => will call NMAP on localhost
 68 #               -s external => will call ss on network (non-local)
 69
 70 mode=""
 71 target=""
 72
 73 while getopts ":ns" opt; do
 74         case $opt in
 75                 n) mode="nmap" ;;
 76                 s) mode="ss" ;;
 77                 *) helpMenu; exit 1 ;;
 78         esac
 79 done
 80 shift $((OPTIND - 1))
 81
 82 target="$1"
 83
 84 if [ -z "$mode" ]; then
 85         helpMenu
 86         exit 1
 87 fi
 88
 89 if [[ "$target" != "internal" && "$target" != "external" ]]; then
 90         helpMenu
 91         exit 1
 92 fi
 93
 94 if [ "$mode" = "nmap" ]; then
 95         if [ "$target" = "internal" ]; then
 96                 InternalNmap
 97         else
 98                 ExternalNmap
 99         fi
100 else
101         if [ "$target" = "internal" ]; then
102                 InternalListeningPorts
103         else
104                 ExternalListeningPorts
105         fi
106 fi
107
