#!/bin/bash

git clone https://github.com/XargonWan/RetroDECK --depth=1 RetroDECK

# Creating MAME manifest
manifest_header="manifest-header.yml"
module="module.yml"
output_manifest="net.retrodeck.supermodel.yml"
command="/app/bin/supermodel" 

# sed -n '/command/q;p' RetroDECK/net.retrodeck.retrodeck.yml > "$manifest_header"  TEMPORARY DISABLED TO TRY A BUILD WITH ANOTHER RUNTIME
echo -e "command: $command\n" >> "$manifest_header"
sed -i '/^[[:space:]]*#/d' "$manifest_header"
sed -i 's/[[:space:]]*#.*$//' "$manifest_header"
sed -n '/finish-args:/,${/cleanup:/q;p;}' RetroDECK/net.retrodeck.retrodeck.yml >> "$manifest_header"

sed -i 's/net.retrodeck.retrodeck/net.retrodeck.supermodel/' "$manifest_header"

cat "$manifest_header" > "$output_manifest"
cat "$module" >> "$output_manifest"

rm -rf RetroDECK