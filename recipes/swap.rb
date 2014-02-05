#
# Cookbook Name:: rs-base
# Recipe:: swap
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

marker "recipe_start_rightscale" do
  template "rightscale_audit_entry.erb"
end

# Create base directory for swap file location
dir = ::File.dirname(node['rs-base']['swap']['file'])
directory dir do
  owner "root"
  group "root"
  mode 00755
  recursive true
  action :create
end

swap_file node['rs-base']['swap']['file'] do
  # The swap cookbook expects the size to be in MB. So convert the size in GB to MB.
  size node['rs-base']['swap']['size'].to_i * 1024
  persist true
  action :create
end

#TODO deal with collectd
include_recipe "collectd::default"

collectd_plugin "swap"