#!/usr/bin/env bats

@test "removes the swapfile" {
  test ! -e /mnt/ephemeral/swapfile
}
