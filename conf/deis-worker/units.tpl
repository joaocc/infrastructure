- name: etcd.service
  mask: true

- name: deis-preseed.service
  drop-ins:
    - name: 00-set-deis-components.conf
      content: |
        [Service]
        Environment="DEIS_COMPONENTS=logspout publisher"

${file("conf/shared/robins.yml")}
