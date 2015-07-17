set -eo pipefail

# Check to see if the program is running, error if it is
if [ -f /var/run/blackhole.pid ] ; then
  echo "According to /var/run/blackhole.pid, this script is already running. Exiting." 1>&2 ;
  exit 1 ;
fi ;

# Track the process
echo $BASHPID > /var/run/blackhole.pid ;

# Keys
export WHITELIST_KEY=/blackhole/whitelist
export BLACKLIST_KEY=/blackhole/whitelist

# Ensure namespaces are created
etcdctl mkdir $WHITELIST_KEY || true
etcdctl mkdir $BLACKLIST_KEY || true

add_to_whitelist(){
  ip=$1
  if ! is_whitelisted "$ip" ; then
    date | etcdctl set "$WHITELIST_KEY"/"$ip"
  fi
}

add_to_blacklist(){
  ip=$1
  if ! etcdctl get "$BLACKLIST_KEY"/"$ip" > /dev/null 2>&1 ; then
    date | etcdctl set "$BLACKLIST_KEY"/"$ip"
  fi
}

is_whitelisted(){
  ip=$1
  if ! etcdctl get "$WHITELIST_KEY"/"$ip" > /dev/null 2>&1 ; then
    false
  else
    true
  fi
}

# Whitelist fleet machines
(
  last --time-format notime -awi | grep pts | cut -c38-
  fleetctl list-machines --fields=ip -no-legend
) | sort | uniq | \
while read ip ; do
  add_to_whitelist "$ip"
done

# Scanning Program
(
  /usr/bin/journalctl -f -o json | \
  grep --line-buffered sshd | \
  grep --line-buffered -e "Disconnecting: Too many authentication failures\|Failed password for" | \
  sed -u -e "s/^.*sshd@.*:22-//" -e "s/:.*$//" | \
  while read ip ; do
    add_to_blacklist "$ip"
  done & READER_PID=$!
  (( JOURNALCTL_PID=READER_PID+1 )) ;
  _term() { echo Killing journalctl pid $JOURNALCTL_PID 2>&1 ;
    kill $JOURNALCTL_PID ;
    exit 0 ;
  } ;
  trap _term SIGINT SIGTERM EXIT ;
  wait $READER_PID
) & SCANNER_PID=$!+1 ;


# Blocker Program
# Watches for new keys in etcd and blocks them
(
  etcdctl exec-watch --recursive /blackhole/blacklist -- sh -c '
    ip=$(echo $ETCD_WATCH_KEY | sed "s/.*\///")
    if ! is_whitelisted ; then
      (ip route add blackhole "$ip" && echo "added $ip to block list") | true
    fi
  ' & WATCHER_PID=$!

  _term() { echo Killing etdctl pid $WATCHER_PID 2>&1
    kill $WATCHER_PID
    exit 0
  }
  trap _term SIGINT SIGTERM EXIT
  wait $WATCHER_PID
) & BLOCKER_PID=$!+1

# Existing Key Blocker
# Blocks all existing keys in etcd
for key in $(etcdctl ls /blackhole/blacklist) ; do
  ip=$(echo "$key" | sed "s/.*\///")
  if ! is_whitelisted ; then
    (ip route add blackhole "$ip" && echo "added $ip to block list") | true
  fi
done

# Termination Script
_term() {
  echo "Killing Blackhole Processes"  2>&1
  kill $SCANNER_PID > /dev/null 2>&1 || true
  kill $BLOCKER_PID > /dev/null 2>&1 || true
  rm -f /var/run/blackhole.pid
  exit 0
}
trap _term SIGINT SIGTERM EXIT
echo $BASHPID > /var/run/blackhole.pid
wait $SCANNER_PID
wait $BLOCKER_PID
