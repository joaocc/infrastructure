export DEISCTL_TUNNEL="deisctl.brandfolder.host:2323"
export FLEETCTL_TUNNEL=$DEISCTL_TUNNEL
export FLEETCTL_STRICT_HOST_KEY_CHECKING=false
export PATH=$HOME/bin:$PATH

eval `ssh-agent -s`
ssh-add ~/.ssh/deis