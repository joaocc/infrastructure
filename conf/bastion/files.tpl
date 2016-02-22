- path: /home/core/.ssh/deis
  owner: core
  permissions: '0400'
  content: |
    ${join("\n    ", split("\n", file("private/.ssh/deis")))}}

- path: /home/core/.bash_profile
  owner: core
  permissions: '0755'
  content: |
    eval `ssh-agent -s`
    ssh-add ~/.ssh/deis

- path: /etc/profile.d/cluster-versions-alias.sh
  permissions: '0755'
  content: |
    alias cluster-versions='echo "" ; for ip in `fleetctl list-machines --no-legend --fields ip | grep $(hostname -i) --invert-match` ; do fleetctl list-machines | grep $ip ; ssh -o "StrictHostKeyChecking no" $ip "sh -c \"cat /etc/os-release | grep VERSION=\"" ; echo "" ; done'

- path: /etc/ssh/sshd_config
  permissions: '0600'
  owner: root:root
  content: |
    # Use most defaults for sshd configuration.
    AuthorizedKeysFile .ssh/authorized_keys
    AuthorizedKeysCommand /opt/bin/github-keys
    AuthorizedKeysCommandUser root
    PasswordAuthentication no
    UsePrivilegeSeparation sandbox
    Subsystem sftp internal-sftp
    ClientAliveInterval 180
    UseDNS no

# Github keys command
- path: /opt/bin/github-keys
  permissions: 0755
  owner: root:root
  content: |
    #!/bin/bash
    if [ ! -f /etc/docker-volume-formatted ] ; then exit 22 ; fi
    touch /var/log/authorized-keys.log
    echo $@ >> /var/log/authorized-keys.log

    # Capture the user
    user=$1

    # Capture keys
    keys=`DOCKER_HOST=unix:///var/run/early-docker.sock docker run --net host --rm brandfolder/github-keys:latest --token ${trimspace(file("private/misc/github-token"))} brandfolder bastion user-keys $user`
    if [ $? -ne 0 ] ; then
      echo "cannot authenticate $user" >> /var/log/authorized-keys.log
      exit 22
    fi
    echo "$keys" >> /var/log/authorized-keys.log
    echo "$keys"

${file("conf/bastion/app_command.yml")}
