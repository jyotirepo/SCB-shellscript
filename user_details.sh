#Remove older users report
rm -rf users_details.csv
echo "Host Name, Host IP,  Username , Account Expiry Date , Password Change Date" >> users_details.csv
#echo "---------------------------------------------------" >> users_details.csv
chmod -R 777 users_details.csv
for user in $(cut -d: -f1 /etc/passwd); do
    expiry_date=$(chage -l $user | grep "Account expires" | awk -F": " '{print $2}')
    password_change=$(chage -l $user | grep "Last password change" | awk -F": " '{print $2}')
    password_change=$(date -d "$password_change" +'%d-%m-%Y')
    hostip=$(echo $(ifconfig | grep 'inet ' | awk '{print $2}') | awk '{print $1}') 
    echo "$HOSTNAME, $hostip,  $user, $expiry_date, $password_change"
done >> users_details.csv

