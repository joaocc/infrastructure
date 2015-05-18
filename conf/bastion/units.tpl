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
- name: github-key-retriever.service
  command: start
  content: |
    [Unit]
    Description=Pull Github Key Fetcher
    After=early-docker.service
    Before=early-docker.target
    Wants=network-online.target
    After=network-online.target

    [Service]
    RemainAfterExit=yes
    Type=oneshot
    Environment="DOCKER_HOST=unix:///var/run/early-docker.sock"
    ExecStart=/usr/bin/docker pull brandfolder/github-keys:latest

${file("conf/shared/robins.yml")}

- name: sshd.service
  drop-ins:
    - name: 00-start-after-retriever.conf
      content: |
        [Unit]
        After=github-key-retriever.service
        Requires=github-key-retriever.service

