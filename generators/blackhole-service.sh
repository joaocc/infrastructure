DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
ENCODED_SCRIPT=$(cat $DIR/../scripts/blackhole.sh | base64)
DEST="$DIR/../custom-units/blackhole.service"

cat <<TEMPLATE > $DEST
# Unit file generated from generators/blackhole-service.sh
[Unit]
Description=block malicious ssh connections
After=sshd.service
Requires=sshd.service

[Service]
# Script encoded from scripts/blackhole.sh
ExecStart=/bin/sh -c 'echo "$ENCODED_SCRIPT" | base64 -d | bash'

[X-Fleet]
MachineMetadata=bastion

TEMPLATE

cat $DEST
