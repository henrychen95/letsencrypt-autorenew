#!/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin
export PATH

# Lets Encrypt Path
LE_PATH="/letsencrypt"

# Apache bin path
apachePATH="/usr/sbin/httpd"

# Email
email="Your email"

# Domain
domains=(Your-Domain1 Your-Domain2 Your-Domain3)

# Process Domains, please don't modify this.
renewDomains=""

for domain in ${domains[@]}; do
    renewDomains="$renewDomains -d $domain"
done

# Stop Apache
$apachePATH -k stop

# Renew SSL
cd $LE_PATH
./letsencrypt-auto certonly --standalone-supported-challenges http-01 $renewDomains --server https://acme-v01.api.letsencrypt.org/directory --email $email --agree-tos --renew-by-default

# Start Apache
$apachePATH -k start