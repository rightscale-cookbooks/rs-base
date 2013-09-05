#!/usr/bin/env bats

@test "Creates the swap file." {
  test -f /mnt/ephemeral/swapfile
}

@test "Has the correct swapfile size." {
  ls --size --block-size=M /mnt/ephemeral/swapfile | grep "^1024M"
}

@test "Swap is in fstab." {
  grep /mnt/ephemeral/swapfile /etc/fstab
}
