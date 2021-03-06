# frozen_string_literal: true
#
# Cookbook Name:: rs-base
# Attribute:: collectd
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
default['rs-base']['monitoring_type'] = 'collectd'
default['rs-base']['collectd_server'] = node['rightscale']['monitoring_collector_http']
default['rs-base']['collectd_server_port'] = node['rightscale']['RS_RLL_PORT']
