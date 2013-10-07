@test "rsyslog remote logging server setup" {
  grep 192.168.0.1 /etc/rsyslog.d/49-remote.conf
}
