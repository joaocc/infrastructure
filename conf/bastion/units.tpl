- name: etcd.service
  mask: true

# Deis ctl
# Used to install and manage deis
- name: install-deisctl.service
  command: start
  content: |
    [Unit]
    Description=Install deisctl utility
    ConditionPathExists=!/opt/bin/deisctl
    After=refresh-infrastructure.service

    [Service]
    Type=oneshot
    ExecStart=/usr/bin/sh -c 'curl -sSL --retry 5 --retry-delay 2 http://deis.io/deisctl/install.sh | sh -s $DEIS_VERSION'

# Pull Latest ssh key retriever
- name: pull-brandfolder-github-keys.service
  command: start
  content: |
    [Unit]
    Description=Pull Github Key Fetcher
    After=docker.service
    Requires=docker.service

    [Service]
    Type=oneshot
    ExecStart=/usr/bin/docker pull brandfolder/github-keys:latest

${file("conf/shared/robins.yml")}
