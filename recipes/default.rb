# frozen_string_literal: true
#
# Cookbook Name:: rs-base
# Recipe:: default
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

include_recipe 'rightscale_tag::default'
include_recipe 'rs-base::swap'
include_recipe 'rs-base::ntp'
include_recipe 'rs-base::rsyslog'
include_recipe "rs-base::monitoring_#{node['rs-base']['monitoring_type']}"
include_recipe 'rs-base::sysctl'
