#
# Cookbook Name:: rs-base
# Recipe:: create_swap
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

marker "recipe_start"

#TODO Validate 'swap_size'.
#if node['rs-base']['swap']['size'] !~ /^\d*[.]?\d+$/
#  raise "ERROR: invalid swap size: #{node['rs-base']['swap']['size']}"
#else
#XXX do we want to stick with old cookbooks usage of GB or go with
# community usage of MB?  Going with community for now.
#  # Convert swap_size from GB to MB.
#  swap_size = ((node['rs-base']['swap']['size'].to_f)*1024).to_i
#end

#TODO add check if requested size is to large.  From old cookbook
# Validate 'swap_file'.
if node['rs-base']['swap']['file'] !~ 
  /^\/{1}(((\/{1}\.{1})?[a-zA-Z0-9 ]+\/?)+(\.{1}[a-zA-Z0-9]{2,4})?)$/
  raise "ERROR: invalid swap file name: #{node['rs-base']['swap']['file']}"
end

# Create base directory for swap file location
bash 'mkdir swap file location' do
  flags "-ex"
#TODO change to use chef directory resource
  code <<-eof
    mkdir -p `dirname #{node['rs-base']['swap']['file']}`
  eof
end

if node['rs-base']['swap']['size'] == 0
 log "Swap file size set to 0 - skipping setup" 
else
  swap_file node['rs-base']['swap']['file'] do
    size node['rs-base']['swap']['size']
    persist true
    action :create
  end
  #TODO enable collectd swap plugin??  Was in old cookbook, but
  # do we want to that here or in a separate recipe?
end
