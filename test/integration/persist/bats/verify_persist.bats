#!/usr/bin/env bats

@test "writes fstab" {
  cat /etc/fstab | grep /mnt/ephemeral/swapfile
}
