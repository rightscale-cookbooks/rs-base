#!/usr/bin/env bats

@test "TEST: grep for time.rightscale.com in ntp.conf file" {
  grep -q 'time.rightscale.com' /etc/ntp.conf
}

@test "TEST: verify ntp service is running" {
  pgrep ntp
}
