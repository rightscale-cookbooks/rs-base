#!/usr/bin/env bats

case `unset GEM_HOME; ohai platform_family | grep -v '\[\|\]'` in
*"debian"*)
  CONF_DIR="/etc/collectd"
  PLUGIN_CONF_DIR="/etc/collectd/plugins"
  LOG_LOCATION="/var/log/syslog";
  ;;
*"rhel"*)
  CONF_DIR="/etc"
  PLUGIN_CONF_DIR="/etc/collectd.d"
  LOG_LOCATION="/var/log/messages";
  ;;
esac

@test "collectd process is running" {
  pgrep collectd
}

@test "remote collectd server is configured" {
  grep 'sketchy1-66\.rightscale\.com' $PLUGIN_CONF_DIR/network.conf
}

@test "config files exist" {
  for CONF in collectd.conf thresholds.conf; do
    test -f $CONF_DIR/$CONF
  done
}

@test "plugin config files exist" {
  for CONF in cpu.conf df.conf load.conf disk.conf memory.conf swap.conf processes.conf users.conf; do
    test -f $PLUGIN_CONF_DIR/$CONF
  done
}

@test "receiving socket opened by the server" {
  netstat -lnp | grep collectd
}

@test "plugins are loaded" {
  ! (tail -n 20 $LOG_LOCATION | grep "you didn't load any write plugins")
}

@test "collectd is sending data" {
  # Use a 30 second timeout, this usually catches at least two messages
  timeout 30s tcpdump -i eth0 -p -n -nn -s 1500 udp port 3011 > /tmp/tcpdump || true
  grep '\.3011: UDP' /tmp/tcpdump
}
