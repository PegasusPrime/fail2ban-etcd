# fail2ban-etcd

Setup a 3 or 5 node etcd cluster. I used wireguard to link the cluster together

Adjust fail2ban to update the etcd endpoint with new addresses

/etc/fail2ban/action.d/etcd.conf

/etc/fail2ban/jail.local
