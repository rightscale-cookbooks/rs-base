#!/usr/bin/env bats

@test "Verify collectd process is running." {
  pgrep collectd
}

@test "Verfiy remote collectd server is configured" {
  grep example.com /etc/collectd/plugins/network.conf
}

@test "Verify collectd is sending data" {
#use tcpdump to verify data is being sent out on port 3011???
}
