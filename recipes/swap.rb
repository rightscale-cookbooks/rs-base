# frozen_string_literal: true
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
# The swap cookbook expects the size to be in MB.
size_mb = node['rs-base']['swap']['size'].to_i

if size_mb > 0

  include_recipe 'ephemeral_lvm::default'

  # Create base directory for swap file location
  dir = ::File.dirname(node['rs-base']['swap']['file'])
  directory dir do
    owner 'root'
    group 'root'
    mode 00755
    recursive true
    action :create
  end

  swap_file node['rs-base']['swap']['file'] do
    size size_mb
    action :create
  end

end
