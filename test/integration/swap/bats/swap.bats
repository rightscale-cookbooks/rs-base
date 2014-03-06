#!/usr/bin/env bats

SWAPFILE="/mnt/ephemeral/swapfile"

@test "Creates the swap file." {
  test -f $SWAPFILE
}

@test "Has the correct swapfile size." {
  ls -l --human-readable --block-size=G $SWAPFILE | grep "1G"
}

@test "Swapfile is enabled." {
  swapon -s | grep $SWAPFILE
}

@test "Swap is in fstab." {
  grep $SWAPFILE /etc/fstab
}

@test "Collectd configured for swap" {
  grep -r -P '^LoadPlugin \"swap\"$' /etc/collectd*
}

@test "Collectd sending swap metric data" {
  tcpdump -i any -X udp port 3011 -c10 | grep swap
}