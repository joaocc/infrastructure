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