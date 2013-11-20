#!/usr/bin/env bats

@test "Verify collectd process is running." {
  pgrep collectd
}

@test "Verfiy remote collectd server is configured" {
  grep sketchy /etc/collectd/plugins/network.conf
}

@test "Verify collectd is sending data" {
#use tcpdump to verify data is being sent out on port 3011???
}

@test "Verify cpu.conf was created" {
  [ -e '/etc/collectd/plugins/cpu.conf' ]
}

@test "Verify df.conf was created" {
  [ -e '/etc/collectd/plugins/df.conf' ]
}

@test "Verify load.conf was created" {
  [ -e '/etc/collectd/plugins/load.conf' ]
}

@test "Verify disk.conf was created" {
  [ -e '/etc/collectd/plugins/disk.conf' ]
}

@test "Verify memory.conf was created" {
  [ -e '/etc/collectd/plugins/memory.conf' ]
}

@test "Verify processes.conf was created" {
  [ -e '/etc/collectd/plugins/processes.conf' ]
}

@test "Verify users.conf was created" {
  [ -e '/etc/collectd/plugins/users.conf' ]
}

@test "Check for process collectdmon running" {
  ps aux | grep collectdmon | grep -v grep 
}

@test "Verify receiving socket opened by the server" {
  netstat -lnp | grep collectd
}

