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

- path: /etc/ssh/sshd_config
  permissions: 0600
  owner: root:root
  content: |
    # Use most defaults for sshd configuration.
    AuthorizedKeysFile .ssh/authorized_keys
    AuthorizedKeysCommand /opt/bin/github-keys
    AuthorizedKeysCommandUser root
    UsePrivilegeSeparation sandbox
    Subsystem sftp internal-sftp
    ClientAliveInterval 180
    UseDNS no

- path: /opt/bin/github-keys
  permissions: 0755
  owner: root:root
  content: |
    #!/bin/bash
    DOCKER_HOST=unix:///var/run/early-docker.sock docker run --net host --rm brandfolder/github-keys:latest brandfolder bastion --token ${file("private/misc/github-token")}
