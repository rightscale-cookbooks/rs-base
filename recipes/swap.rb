#
# Cookbook Name:: rs-base
# Recipe:: swap
#
# Copyright (C) 2015 RightScale, Inc.
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

# Create base directory for swap file location
dir = ::File.dirname(node['rs-base']['swap']['file'])
directory dir do
  owner 'root'
  group 'root'
  mode 00755
  recursive true
  action :create
end

# The swap cookbook expects the size to be in MB. So convert the size in GB to MB.
size_mb = node['rs-base']['swap']['size'].to_i * 1024

# RHEL|CentOS 7.* currently fails using an 'fallocate' file as swap which is what is
# done by the 'swap' community cookbook. Following is a workaround to create the file first with 'dd'.
# 'dd' command generated from https://github.com/sethvargo-cookbooks/swap/blob/v0.3.8/libraries/swapfile_provider.rb#L141
if platform_family?('rhel') && node['platform_version'] =~ /^7\./
  execute "dd if=/dev/zero of=#{node['rs-base']['swap']['file']} bs=1048576 count=#{size_mb}"
end

swap_file node['rs-base']['swap']['file'] do
  size size_mb
  action :create
end
