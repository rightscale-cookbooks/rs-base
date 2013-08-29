#
# Cookbook Name:: rs-base
# Recipe:: remove_swap
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

swap_file node['rs-base']['swap']['file'] do
  size node['rs-base']['swap']['size']
  action :remove
end
#TODO disable collectd swap plugin??  Was in old cookbook, but
# do we want to that here or in a separate recipe?
