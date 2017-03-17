# frozen_string_literal: true
default['rs-base']['sysctl']['settings'] = {
  'vm.swappiness' => 20,
  'vm.dirty_ratio' => 40,
  'vm.dirty_background_ratio' => 10,
  'net.core.somaxconn' => 1000,
  'net.core.netdev_max_backlog' => 5000,
  'net.core.rmem_max' => 16_777_216,
  'net.core.wmem_max' => 16_777_216,
  'net.ipv4.tcp_wmem' => '4096 12582912 16777216',
  'net.ipv4.tcp_rmem' => '4096 12582912 16777216',
  'net.ipv4.tcp_max_syn_backlog' => 8096,
  'net.ipv4.tcp_slow_start_after_idle' => 0,
  'net.ipv4.tcp_tw_reuse' => 1,
}
