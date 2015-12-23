#cloud-config
coreos:
  fleet:
    public-ip: $private_ipv4
    metadata: "${fleet_tags}"
    engine-reconcile-interval: 10
    etcd-request-timeout: 5.0
    agent-ttl: 120s

  update:
    reboot-strategy: best-effort
    group: stable

  etcd2:
    discovery: ${file("private/etcd/discovery-url")}
    advertise-client-urls: "http://$private_ipv4:2379"
    initial-advertise-peer-urls: "http://$private_ipv4:2380"
    listen-client-urls: "http://0.0.0.0:2379,http://0.0.0.0:4001"
    listen-peer-urls: "http://$private_ipv4:2380,http://$private_ipv4:7001"

  units:
    ${join("\n    ", split("\n", units))}

    ${join("\n    ", split("\n", file("conf/shared/units.yml")))}

write_files:
  - path: /etc/deis-release
    content: |
      DEIS_RELEASE=v${file("conf/deis-version")}

  ${join("\n  ", split("\n", files))}

  ${join("\n  ", split("\n", file("conf/shared/files.yml")))}
