export FLEETCTL_TUNNEL="deisctl.brandfolder.host:2323"
export FLEETCTL_STRICT_HOST_KEY_CHECKING=false
export DEISCTL_TUNNEL=$FLEETCTL_TUNNEL
export ETCD_PEERS="etcd.brandfolder.host:4001"
export PATH=$HOME/bin:$PATH

eval `ssh-agent -s`
ssh-add ~/.ssh/deis