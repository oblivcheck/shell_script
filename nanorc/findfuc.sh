#!/bin/bash
path="$HOME/srcds/addons/sourcemod/scripting/include/*"
# Linux
# output=/usr/share/nano/sp.nanorc
# FreeBSD
output="/usr/local/share/nano/sp.nanorc"

echo "# findfuc.sh" >> $output
grep -oh -R 'void \([^ ]*\)([^)]*)' $path | sed -n 's/void \([^ ]*\)([^)]*)/color brightblue "\\\<(\1)\\\>"/p' >> $output
grep -oh -R 'Action \([^ ]*\)([^)]*)' $path | sed -n 's/Action \([^ ]*\)([^)]*)/color brightblue "\\\<(\1)\\\>"/p' >> $output
grep -oh -R 'bool \([^ ]*\)([^)]*)' $path | sed -n 's/bool \([^ ]*\)([^)]*)/color brightblue "\\\<(\1)\\\>"/p' >> $output
grep -oh -R 'int \([^ ]*\)([^)]*)' $path | sed -n 's/int \([^ ]*\)([^)]*)/color brightblue "\\\<(\1)\\\>"/p' >> $output
grep -oh -R 'float \([^ ]*\)([^)]*)' $path | sed -n 's/float \([^ ]*\)([^)]*)/color brightblue "\\\<(\1)\\\>"/p' >> $output
