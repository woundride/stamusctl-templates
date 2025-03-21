#! /bin/sh
#
# Example of rotating the logs within the Suricata container.
#
# Add -v for verbose output.
# Add -f to force rotation.

echo "Rotating Suricata logs"
docker exec {{template "base-name" .}}-suricata-{{ .Release.seed }} logrotate -v /etc/logrotate.d/suricata $@ && echo "done." || echo "ERROR"