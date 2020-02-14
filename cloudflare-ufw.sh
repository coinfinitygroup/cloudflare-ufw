#!/bin/sh

curl -s https://www.cloudflare.com/ips-v4 -o /tmp/cf_ips_v4
#curl -s https://www.cloudflare.com/ips-v6 >> /tmp/cf_ips_v6

# Allow all traffic from Cloudflare IPs (no ports restriction)
for cfip in `cat /tmp/cf_ips_v4`; do ufw route allow proto tcp from $cfip to any port 80,443 comment 'Cloudflare IP'; done
#for cfip in `cat /tmp/cf_ips_v6`; do ufw insert  allow proto tcp from $cfip comment 'Cloudflare IP'; done

ufw reload > /dev/null

# OTHER EXAMPLE RULES
# Retrict to port 80
#for cfip in `cat /tmp/cf_ips`; do ufw allow proto tcp from $cfip to any port 80 comment 'Cloudflare IP'; done

# Restrict to port 443
#for cfip in `cat /tmp/cf_ips`; do ufw allow proto tcp from $cfip to any port 443 comment 'Cloudflare IP'; done

# Restrict to ports 80 & 443
#for cfip in `cat /tmp/cf_ips`; do ufw allow proto tcp from $cfip to any port 80,443 comment 'Cloudflare IP'; done
