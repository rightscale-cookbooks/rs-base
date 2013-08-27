@test "TEST: grep for rightscale in ntp.conf file" {
  if grep -q 'rightscale' /etc/ntp.conf; then
    return 0 # rightscale is found in the file
  else
    return 1 # rightscale is not found
  fi
}

@test "TEST: grep for leftscale in ntp.conf file" {
  if echo "$output" | grep -q 'leftscale' /etc/ntp.conf; then
    return 0 # leftscale is found in the file
  else
    return 1 # leftscale is not found
  fi
}

