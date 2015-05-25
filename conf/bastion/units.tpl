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
    Requires=early-docker.service

    [Service]
    Environment="DOCKER_HOST=unix:///var/run/early-docker.sock"
    ExecStart=/usr/bin/sh -c 'docker pull brandfolder/github-keys:latest'
    RemainAfterExit=yes
    Type=oneshot

- name: sshd.service
  drop-ins:
    - name: 00-start-after-retriever.conf
      content: |
        [Unit]
        After=github-key-retriever.service
        Requires=github-key-retriever.service

# Sync Github Users
- name: sync-github-users.service
  command: start
  content: |
    [Unit]
    Description=Sync users with github
    After=github-key-retriever.service
    Requires=github-key-retriever.service

    [Service]
    Environment="DOCKER_HOST=unix:///var/run/early-docker.sock"
    ExecStart=/bin/bash -c '\
      users=`docker run --net host --rm brandfolder/github-keys:latest --token ${file("private/misc/github-token")} brandfolder bastion list-users --downcase`; \
      for user in $users ; do \
        useradd -p "*" -m "$user" -U -G core 2> /dev/null ; \
        if [ $? -eq 0 ] ; then \
          cp /home/core/.ssh/deis /home/$user/.ssh/deis ; \
          chown $user /home/$user/.ssh/deis ; \
          rm /home/$user/.bash_profile ; \
          cat /home/core/.bash_profile >> /home/$user/.bash_profile ; \
          chown $user /home/$user/.bash_profile ; \
        fi; \
      done'

# Update github users on a timer
- name: sync-github-users.timer
  command: start
  content: |
    [Unit]
    Description=Sync Github Users Timer
    After=sync-github-users.service
    Requires=sync-github-users.service

    [Timer]
    OnCalendar=minutely

${file("conf/shared/robins.yml")}