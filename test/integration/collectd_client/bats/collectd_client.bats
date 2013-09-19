#!/usr/bin/env bats

@test "Verify collectd process is running." {
  pgrep collectd
}
