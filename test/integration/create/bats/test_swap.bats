#!/usr/bin/env bats

@test "creates the swap file" {

  test -f /mnt/ephemeral/swapfile
}

@test "has the correct size" {
  ls -l --block-size=M /mnt/ephemeral | grep "swap" | grep "1024M"
}
