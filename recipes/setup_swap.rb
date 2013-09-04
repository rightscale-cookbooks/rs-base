#
# Cookbook Name:: rs-base
# Recipe:: setup_swap
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


#TODO add check if requested size is invalid or to large.  From old cookbook

# Validate 'swap_file' name.
if node['rs-base']['swap']['file'] !~ 
  /^\/{1}(((\/{1}\.{1})?[a-zA-Z0-9 ]+\/?)+(\.{1}[a-zA-Z0-9]{2,4})?)$/
  raise "ERROR: invalid swap file name: #{node['rs-base']['swap']['file']}"
end

# Create base directory for swap file location
dir = File.dirname node['rs-base']['swap']['file']
directory "#{dir}" do
  owner "root"
  group "root"
  mode 00644
  recursive true
  action :create
end

if node['rs-base']['swap']['size'].to_i == 0
  log "Swap file size set to 0 - skipping setup" 
else
  swap_file node['rs-base']['swap']['file'] do
    size node['rs-base']['swap']['size'].to_i
    persist true
    action :create
  end
end

#TODO deal with collectd
