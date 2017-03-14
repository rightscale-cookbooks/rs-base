# frozen_string_literal: true
#
# Cookbook Name:: rs-base
# Recipe:: collectd
#
# Copyright (C) 2013 RightScale, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

marker 'recipe_start_rightscale' do
  template 'rightscale_audit_entry.erb'
end

include_recipe 'yum-epel' if node['platform_family'] == 'rhel'
include_recipe 'selinux_policy::install' if node['platform_family'] == 'rhel'

selinux_policy_module 'rightscale_collectd' do
  content <<-eos
    module rightscale_collectd 1.0;
    require {
            type unreserved_port_t;
            type ephemeral_port_t;
            type policykit_t;
            type tmp_t;
            type collectd_t;
            class tcp_socket name_connect;
            class dir { create read write open getattr search remove_name add_name rmdir };
            class file read;
            class udp_socket name_bind;
            class sock_file { create read write open getattr setattr };
    }

    #============= collectd_t ==============
    allow collectd_t ephemeral_port_t:tcp_socket name_connect;
    allow collectd_t tmp_t:dir { create read write open getattr search remove_name add_name rmdir };
    allow collectd_t tmp_t:sock_file { create read write open getattr setattr };
    allow collectd_t unreserved_port_t:udp_socket name_bind;
  eos
  action :deploy
  only_if { node['platform_family'] == 'rhel' }
end

Chef::Log.info 'setting collectd defaults'
node.default['collectd']['service']['configuration']['Hostname'] = node['rs-base']['collectd_hostname']
node.default['collectd']['service']['configuration']['F_Q_D_N_Lookup'] = false
node.default['collectd']['service']['configuration']['interval'] = 20
include_recipe 'collectd::default'

raise 'No sketchy server set' unless node['rs-base']['collectd_server']

Chef::Log.info 'Setting DF Plugin Options'
node.default['collectd-plugins']['df']['report_reserved'] = false
node.default['collectd-plugins']['df']['FSType'] = %w(proc sysfs fusectl debugfs securityfs devtmpfs devpts tmpfs)
node.default['collectd-plugins']['df']['ignore_selected'] = true

Chef::Log.info 'Setting UnixSock Plugin Options'
node.default['collectd-plugins']['unixsock']['SocketFile'] = '/tmp/collectd.sock'
node.default['collectd-plugins']['unixsock']['SocketGroup'] = 'collectd'
node.default['collectd-plugins']['unixsock']['SocketPerms'] = '0770'
node.default['collectd-plugins']['unixsock']['DeleteSocket'] = true

Chef::Log.info 'Setting Statsd Plugin Options'
node.default['collectd-plugins']['statsd']['Host'] = '::'
node.default['collectd-plugins']['statsd']['Port'] = '8125'

Chef::Log.info 'Running collectd_plugins default'
include_recipe 'collectd_plugins::default'

node.default['collectd-plugins']['interface']['interface'] = %w(lo eth0)
include_recipe 'collectd_plugins::interface'

include_recipe 'collectd_plugins::disk'
include_recipe 'collectd_plugins::processes'
# include_recipe 'collectd_plugins::users'

if ::File.exist?('/var/run/rightlink/secret')
  File.read('/var/run/rightlink/secret').each_line do |line|
    k, v = line.strip.split('=')
    node.default['rs-base']['rightscale'][k] = v
  end
else
  raise 'rs-base needs rl10 secrets to operate'
end

node.default['collectd-plugins']['write_http']['U_R_L'] = "http://127.0.0.1:#{node['rs-base']['rightscale']['RS_RLL_PORT']}/rll/tss/collectdv5"
include_recipe 'collectd_plugins::write_http'
include_recipe 'rightscale_tag::monitoring'

bash 'update rsc' do
  flags '-ex'
  code <<-EOF
    whoami >> /tmp/rsc.log
    sudo /usr/local/bin/rsc rl10 update /rll/tss/control enable_monitoring=util -v &>> /tmp/rsc.log
  EOF
  only_if do
    ::File.exist?('/usr/local/bin/rsc')
  end
end
