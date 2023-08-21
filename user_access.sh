#!/bin/bash

echo "Username,Access,Validity"
while IFS=: read -r username _ _ _ _ _ _; do
    access="No"
    validity="N/A"
    
    # Check if the user has a corresponding entry in /etc/shadow
    shadow_line=$(grep "^$username:" /etc/shadow)
    if [ -n "$shadow_line" ]; then
        access="Yes"
        
        # Extract password expiration date (last field) from /etc/shadow
        expiry_date=$(echo "$shadow_line" | cut -d: -f8)
        if [ "$expiry_date" != "": ]; then
            today=$(date +%s)
            expiry_seconds=$(date -d "$expiry_date" +%s)
            validity_days=$(( ($expiry_seconds - $today) / 86400 ))
            validity="$validity_days days"
        fi
    fi
    
    echo "$username,$access,$validity"
done

