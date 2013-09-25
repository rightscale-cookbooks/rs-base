@test "TEST: grep for time.rightscale.com in ntp.conf file" {
  if grep -q 'time.rightscale.com' /etc/ntp.conf; then
    return 0 # rightscale is found in the file
  else
    return 1 # rightscale is not found
  fi
}

@test "TEST: verify ntp service is running" {
  pgrep ntp
}

