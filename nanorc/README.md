## Simple script to generate SourcePawn syntax highlighting for nano

```
# libs path
path="$HOME/srcds/addons/sourcemod/scripting/include/*"
# outfile path
output="/usr/local/share/nano/sp.nanorc"
```


**Modify appropriately if you want:**

```
grep -oh -R 'float \([^ ]*\)([^)]*)' $path | sed -n 's/float \([^ ]*\)([^)]*)/color brightblue "\\\<(\1)\\\>"/p' >> $output
```

