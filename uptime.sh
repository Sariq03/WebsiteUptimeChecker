#!/bin/bash
SITES="sites.txt"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "Website Uptime Check - $DATE"
echo "-----------------------------------"

while read -r site; do
    # Skip empty lines
    [ -z "$site" ] && continue
    
    # Get HTTP status code
    code=$(curl -s -o /dev/null -w "%{http_code}" "$site")
    
    if [[ "$code" -ge 200 && "$code" -lt 400 ]]; then
        echo "$site is UP (HTTP $code) ✅"
    else
        echo "$site is DOWN (HTTP $code) ❌"
    fi
done < "$SITES"
