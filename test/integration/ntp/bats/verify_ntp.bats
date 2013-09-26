#!/usr/bin/env bats

@test "'time.rightscale.com' is in 'ntp.conf'." {
  grep -q 'time.rightscale.com' /etc/ntp.conf
}

@test "NTP service is running." {
  pgrep ntp
}
