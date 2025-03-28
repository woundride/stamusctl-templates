#!/bin/bash
set -e

cp /etc/suricata-configs/* /etc/suricata/.
cp /new_entrypoint.sh /etc/suricata/.

cp /etc/logrotate.d.dist/suricata /etc/logrotate.d/.
chown root:root /etc/logrotate.d/suricata

for src in /etc/suricata.dist/*; do
    filename=$(basename ${src})
    dst="/etc/suricata/${filename}"
    if ! test -e "${dst}"; then
        echo "Creating ${dst}."
        cp -a "${src}" "${dst}"
    fi
done

mkdir -p /var/log/suricata/fpc/
cat /etc/suricata/suricata.yaml | grep "include: selks6-addin.yaml" || echo "include: selks6-addin.yaml" >>/etc/suricata/suricata.yaml && echo 'suricata.yaml edited'

exec /docker-entrypoint.sh $@
