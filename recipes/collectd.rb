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

if node['rightscale'] && node['rightscale']['instance_uuid']
  node.override['collectd']['fqdn'] = node['rightscale']['instance_uuid']
end

if platform_family?('debian')
  ['collectd', 'collectd-core'].each do |package_name|
    apt_preference package_name do
      pin 'version 4*'
      pin_priority '1001'
    end

    package package_name do
      only_if "dpkg -l #{package_name} | grep '^ii *#{package_name} *5'"
      action :purge
    end
  end
end

include_recipe 'collectd::default'

raise 'No sketchy server set' unless node['rs-base']['collectd_server']

collectd_plugin 'syslog'
collectd_plugin 'interface' do
  options(:Interface => 'eth0')
end
collectd_plugin 'cpu'
collectd_plugin 'df' do
  options({
    :report_reserved => false,
    'FSType' => ['proc', 'sysfs', 'fusectl', 'debugfs', 'securityfs', 'devtmpfs', 'devpts', 'tmpfs'],
    :ignore_selected => true,
  })
end
collectd_plugin 'disk'
collectd_plugin 'memory'
collectd_plugin 'swap'
collectd_plugin 'load'
collectd_plugin 'processes'
collectd_plugin 'users'

collectd_plugin 'network' do
  template 'collectd_plugin_network.conf.erb'
  cookbook 'rs-base'
  options({
    :hostname => node['rs-base']['collectd_server'],
    :port => node['rs-base']['collectd_server_port'],
  })
end

include_recipe 'rightscale_tag::monitoring'
