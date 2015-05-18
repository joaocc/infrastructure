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
    AuthorizedKeysCommand /usr/bin/docker run --rm brandfolder/github-keys:latest brandfolder bastion --token 2a279729251227121b386dead12bd2af21ca80b0
    AuthorizedKeysCommandUser root
    UsePrivilegeSeparation sandbox
    Subsystem sftp internal-sftp
    ClientAliveInterval 180
    UseDNS no