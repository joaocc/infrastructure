#cloud-config
coreos:
  fleet:
    public-ip: $private_ipv4
    metadata: "${fleet_tags}"
    etcd_request_timeout: 3.0

  update:
    reboot-strategy: best-effort
    group: stable

  etcd:
    discovery: ${file("private/etcd/discovery-url")}
    addr: $private_ipv4:4001
    peer-addr: $private_ipv4:7001
    peer-election-timeout: 4000
    peer-heartbeat-interval: 1000

  units:
    ${join("\n    ", split("\n", units))}

    ${join("\n    ", split("\n", file("conf/shared/units.yml")))}

write_files:
  - path: /etc/deis-release
    content: |
      DEIS_RELEASE=v${file("conf/deis-version")}

  ${join("\n  ", split("\n", files))}

  ${join("\n  ", split("\n", file("conf/shared/files.yml")))}
